table 60005 "Auto Reservation"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Auto Reservation List";
    DrillDownPageId = "Auto Reservation List";
    Caption = 'Auto Reservation';
    fields
    {
        field(1; "Auto No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Auto;
            Caption = 'Auto No.';
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Line No.';
        }
        field(10; "Client No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
            Caption = 'Client No.';
        }
        field(20; "Reservation Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Reservation Start Date';
            trigger OnValidate()
            var
                errorLbl: Label 'Reservation Start Date cannot be set to earlier than the current date';
            begin
                if (rec."Reservation Start Date" <> 0D) and (rec."Reservation End Date" <> 0D) then
                    ValidateDates();
            end;
        }
        field(30; "Reservation End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Reservation End Date';

            trigger OnValidate()
            begin
                if (rec."Reservation Start Date" <> 0D) and (rec."Reservation End Date" <> 0D) then
                    ValidateDates();
            end;
        }
    }

    keys
    {
        key(Key1; "Auto No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Auto No.", "Client No.", "Reservation Start Date", "Reservation End Date")
        {
        }
    }

    procedure ValidateDates()
    var
        startEarlierThanEndLbl: Label 'The start date is earlier than the end date';
        timeConflictlbl: Label 'The reservation timeframe overlaps with an earlier reservation';
        reservations: Record "Auto Reservation";
    begin
        if "Reservation Start Date" > "Reservation End Date" then
            Error(startEarlierThanEndLbl)
        else begin
            reservations.SetRange("Auto No.", "Auto No.");
            reservations.SetFilter("Reservation End Date", '>%1', WorkDate());
            if reservations.FindSet() then
                repeat
                    if (reservations."Line No." <> "Line No.") then
                        if ("Reservation Start Date" <= reservations."Reservation End Date") and ("Reservation Start Date" >= reservations."Reservation Start Date")
                            or ("Reservation End Date" <= reservations."Reservation End Date") and ("Reservation End Date" >= reservations."Reservation Start Date") then
                            Error(timeConflictlbl);
                until reservations.Next() = 0;
        end;
    end;
}
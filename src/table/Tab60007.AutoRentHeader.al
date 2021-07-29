table 60007 "Auto Rent Header"
{
    DataClassification = ToBeClassified;
    Caption = 'Auto Rent Header';
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';

            trigger OnValidate()
            var
                Lines: Record "Auto Rent Line";
            begin
                TestStatusOpen();
                if rec."No." <> xRec."No." then begin
                    Lines.SetRange("Document No.", xRec."No.");
                    Lines.DeleteAll();
                end;

            end;
        }
        field(10; "Client No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
            Caption = 'Client No.';

            trigger OnValidate()
            begin
                TestStatusOpen();
                ValidateCustomer();
                if rec."Client No." <> xrec."Client No." then begin
                    rec."Rent Start Date" := 0D;
                    rec."Rent End Date" := 0D;
                end;
            end;
        }
        field(20; "Drivers License"; Media)
        {
            DataClassification = ToBeClassified;
            Caption = 'Drivers License';

            trigger OnValidate()
            begin
                TestStatusOpen();
            end;
        }
        field(30; "Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date';

            trigger OnValidate()
            begin
                TestStatusOpen();
            end;
        }
        field(40; "Auto No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Auto;
            Caption = 'Auto No.';

            trigger OnValidate()
            var
                InitialLine: Record "Auto Rent Line";
            begin
                TestStatusOpen();
                if rec."Auto No." <> xrec."Auto No." then begin
                    rec."Rent Start Date" := 0D;
                    rec."Rent End Date" := 0D;
                    EditInitialLine();
                end;
            end;
        }
        field(50; "Rent Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Rent Start Date';

            TableRelation = "Auto Reservation"."Reservation Start Date" where("Client No." = field("Client No."),
                                                                        "Auto No." = field("Auto No."),
                                                                        "Reservation Start Date" = filter('>T'),
                                                                        "Reservation End Date" = filter(<> 0D));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                Reservations: Record "Auto Reservation";
            begin
                TestStatusOpen();
                if rec."Rent Start Date" <> 0D then begin
                    Reservations.SetRange("Auto No.", "Auto No.");
                    Reservations.SetRange("Client No.", "Client No.");
                    Reservations.SetRange("Reservation Start Date", rec."Rent Start Date");
                    if Reservations.FindFirst() then
                        rec."Rent End Date" := Reservations."Reservation End Date";
                end;
                ValidateDates();
            end;
        }
        field(60; "Rent End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Rent End Date';
            trigger OnValidate()
            begin
                TestStatusOpen();
                // if (rec."Rent Start Date" <> 0DT) and (rec."Rent End Date" <> 0DT) then
                //     ValidateDates();
            end;
        }
        field(70; "Sum"; Decimal)
        {
            Editable = false;
            Caption = 'Sum';

            FieldClass = FlowField;
            CalcFormula = Sum("Auto Rent Line"."Sum" where("Document No." = field("No.")));
        }
        field(80; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Rented;
            Editable = false;
            Caption = 'Status';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnRename()
    var
        RentedErrorLbl: Label 'Fields cannot be edited because the vehicle has been rented';
    begin
        if rec.Status = rec.Status::Rented then
            Error(RentedErrorLbl);
    end;

    trigger OnModify()
    var
        RentedErrorLbl: Label 'Fields cannot be edited because the vehicle has been rented';
    begin
        if rec.Status = rec.Status::Rented then
            Error(RentedErrorLbl);
    end;

    trigger OnDelete()
    var
        RentedErrorLbl: Label 'Entry cannot be deleted because the vehicle has been rented';
        Lines: Record "Auto Rent Line";
    begin
        if rec.Status = rec.Status::Rented then
            Error(RentedErrorLbl);

        Lines.SetRange("Document No.", rec."No.");
        if Lines.FindSet() then
            Lines.DeleteAll();
    end;

    procedure GetNewRentNoFromSeries(): Code[20]
    var
        NoSeriesManagement: Codeunit NoSeriesManagement;
        RentSetup: Record "Auto Setup";
    begin
        RentSetup.get();
        RentSetup.TestField("Rental Card No. Series");
        exit(NoSeriesManagement.GetNextNo(RentSetup."Rental Card No. Series", WorkDate(), true));
    end;

    procedure ValidateCustomer()
    var
        Cust: Record Customer;
        DebtErrorLbl: Label 'This customer cannot be selected because of his debt';
        BlockedLbl: Label 'This customer is blocked';
    begin
        if Cust.get(rec."Client No.") then begin
            if Cust.Blocked <> Cust.Blocked::" " then
                Error(BlockedLbl);
            if Cust.Balance > 0 then
                Error(DebtErrorLbl);
        end;
    end;

    procedure ValidateDates()
    var
        startEarlierThanEndLbl: Label 'The start date is earlier than the end date';
        wrongTime: Label 'The time frame does not match with the ones in the customers reservations for this car';
        noReservationLbl: Label 'The customer has not made a reservation for this car';
        reservations: Record "Auto Reservation";
    begin
        if "Rent Start Date" > "Rent End Date" then
            Error(startEarlierThanEndLbl)
        else begin
            reservations.SetRange("Auto No.", "Auto No.");
            reservations.SetRange("Client No.", "Client No.");

            if reservations.FindSet() then begin
                repeat
                    if ("Rent Start Date" = reservations."Reservation Start Date") and ("Rent End Date" = reservations."Reservation End Date") then
                        exit;
                until reservations.Next() = 0;
                Error(wrongTime);
            end
            else
                Error(noReservationLbl);
        end;
    end;

    procedure TestStatusOpen()
    begin
        TestField(Status, Status::Open);
    end;

    procedure EditInitialLine()
    var
        RentLine: Record "Auto Rent Line";
        RentAuto: Record Auto;
        Resource: Record Resource;
    begin
        if RentLine.Get("No.", 1) then
            RentLine.Delete();

        if "Auto No." <> '' then begin
            RentLine.Init();
            RentLine."Document No." := rec."No.";
            RentLine."Line No." := 1;
            RentLine."Type" := RentLine."Type"::Resource;
            RentLine.Quantity := 1;

            if RentAuto.Get(rec."Auto No.") then begin
                RentLine."No." := RentAuto."Rent Service";

                if Resource.Get(RentLine."No.") then begin
                    RentLine.Price := Resource."Unit Price";
                    RentLine.Description := Resource.Name;
                    RentLine."Sum" := RentLine.Quantity * RentLine.Price;
                end;
            end;

            RentLine.Insert();
        end;
    end;


}
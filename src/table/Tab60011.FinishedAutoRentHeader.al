table 60011 "Finished Auto Rent Header"
{
    DataClassification = ToBeClassified;
    Caption = 'Finished Auto Rent Header';
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';
        }
        field(10; "Client No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
            Caption = 'Client No.';
        }
        field(20; "Drivers License"; Media)
        {
            DataClassification = ToBeClassified;
            Caption = 'Drivers License';
        }
        field(30; "Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date';
        }
        field(40; "Auto No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Auto No.';
        }
        field(50; "Rent Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Rent Start Date';
        }
        field(60; "Rent End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Rent End Date';
        }
        field(70; "Sum"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Sum';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    var
        RentedErrorLbl: Label 'Entry cannot be deleted because the vehicle has been rented';
        Lines: Record "Finished Auto Rent Line";
    begin
        Lines.SetRange("Document No.", rec."No.");
        if Lines.FindSet() then
            Lines.DeleteAll();
    end;
}
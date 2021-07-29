table 60009 "Auto Rent Line"
{
    DataClassification = ToBeClassified;

    Caption = 'Auto Rent Line';
    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Line No.';
        }
        field(10; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Item,Resource;
            Caption = 'Type';

            trigger OnValidate()
            var
                CannotEditLbl: Label 'This line cannot be edited';
            begin
                TestStatusOpen();
                if "Line No." = 1 then
                    Error(CannotEditLbl);
            end;
        }
        field(20; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';
            TableRelation =
            if ("Type" = const("Item")) Item else
            if ("Type" = const("Resource")) Resource;

            trigger OnValidate()
            var
                CurrentItem: Record Item;
                CurrentResource: Record Resource;
                CannotEditLbl: Label 'This line cannot be edited';
            begin
                TestStatusOpen();
                if "Line No." = 1 then
                    Error(CannotEditLbl);

                if "Type" = "Type"::Item then begin
                    CurrentItem.Get(rec."No.");
                    rec.Description := CurrentItem.Description;
                    rec.Price := CurrentItem."Unit Cost";
                end
                else
                    if "Type" = "Type"::Resource then begin
                        CurrentResource.Get(rec."No.");
                        rec.Description := CurrentResource.Name;
                        rec.Price := CurrentResource."Unit Cost";
                    end;
                Validate(Price);
            end;
        }
        field(30; Description; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Description';
        }
        field(40; Quantity; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Quantity';

            trigger OnValidate()
            var
                CannotEditLbl: Label 'This line cannot be edited';
            begin
                TestStatusOpen();
                if "Line No." = 1 then
                    Error(CannotEditLbl);

                if rec.Quantity <> xrec.Quantity then
                    rec."Sum" := rec.Price * rec.Quantity;
                Validate("Sum");
            end;
        }
        field(50; Price; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Price';

            trigger OnValidate()
            begin
                rec."Sum" := rec.Price * rec.Quantity;
                Validate("Sum");
            end;
        }
        field(60; "Sum"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Sum';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
            SumIndexFields = "Sum";
        }
    }

    trigger OnInsert()
    var
        ReservedLinenumberLbl: Label 'This Line No. cannot be used';
        RentedErrorLbl: Label 'Fields cannot be edited because the vehicle has been rented';
        Header: Record "Auto Rent Header";
    begin
        if rec."Line No." = 1 then
            Error(ReservedLinenumberLbl);
        Header.Get(rec."Document No.");
        if Header.Status = Header.Status::Rented then
            Error(RentedErrorLbl);
    end;

    trigger OnDelete()
    var
        CannotDeleteLbl: Label 'This line cannot be deleted';
        RentedErrorLbl: Label 'Fields cannot be edited because the vehicle has been rented';
        Header: Record "Auto Rent Header";
    begin
        if rec."Line No." = 1 then
            Error(CannotDeleteLbl);
        Header.Get(rec."Document No.");
        if Header.Status = Header.Status::Rented then
            Error(RentedErrorLbl);
    end;


    // trigger OnModify()
    // var
    //     CannotModifyLbl: Label 'This line cannot be modified';
    //     RentedErrorLbl: Label 'Fields cannot be edited because the vehicle has been rented';
    //     Header: Record "Auto Rent Header";
    // begin
    //     if rec."Line No." = 1 then
    //         Error(CannotModifyLbl);
    //     if Header.Status = Header.Status::Rented then
    //         Error(RentedErrorLbl);
    // end;

    // trigger OnRename()
    // var
    //     CannotRenameLbl: Label 'This line cannot be renamed';
    //     RentedErrorLbl: Label 'Fields cannot be edited because the vehicle has been rented';
    //     Header: Record "Auto Rent Header";
    // begin
    //     if rec."Line No." = 1 then
    //         Error(CannotRenameLbl);
    //     if Header.Status = Header.Status::Rented then
    //         Error(RentedErrorLbl);
    // end;

    procedure TestStatusOpen()
    var
        Header: Record "Auto Rent Header";
    begin
        Header.Get("Document No.");
        Header.TestField(Status, Header.Status::Open);
    end;



}
table 60013 "Finished Auto Rent Line"
{
    DataClassification = ToBeClassified;
    Caption = 'Finished Auto Rent Line';
    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Line No.';
        }
        field(10; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Item,Resource;
            Caption = 'Type';
        }
        field(20; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';
            TableRelation =
            if ("Type" = const("Item")) Item else
            if ("Type" = const(Resource)) Resource;
        }
        field(30; Description; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(40; Quantity; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Quantity';
        }
        field(50; Price; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Price';
        }
        field(60; "Sum"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Sum';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
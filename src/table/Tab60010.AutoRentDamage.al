table 60010 "Auto Rent Damage"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Auto Rent Damage List";
    Caption = 'Auto Rent Damage';
    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Auto Rent Header";
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Line No.';
        }
        field(10; "Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date';
        }
        field(20; Description; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
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
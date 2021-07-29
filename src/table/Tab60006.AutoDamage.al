table 60006 "Auto Damage"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Auto Damage List";
    Caption = 'Auto Damage';
    fields
    {
        field(1; "Auto No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Auto No.';
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(10; "Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Auto No.';
        }
        field(20; Description; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(30; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Active,Closed;
            Caption = 'Status';
        }
    }

    keys
    {
        key(Key1; "Auto No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
table 60002 "Auto Model"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Auto Model List";
    Caption = 'Auto Model';

    fields
    {
        field(1; "Mark Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Auto Mark";
            Caption = 'Mark Code';
        }
        field(2; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Code';
        }
        field(10; Description; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Mark Code", "Code")
        {
            Clustered = true;
        }
    }
}
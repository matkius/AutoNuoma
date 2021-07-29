table 60003 "Auto"
{
    DataClassification = ToBeClassified;
    Caption = 'Auto';
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';
        }
        field(10; Name; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name';
            Editable = false;
        }
        field(20; Mark; Text[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Auto Mark";
            Caption = 'Mark';

            trigger OnValidate()
            begin
                if rec.Mark <> xRec.Mark then begin
                    rec.Model := '';
                    rec.Name := '';
                end;

            end;
        }
        field(30; Model; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Auto Model"."Code" where("Mark Code" = field(Mark));
            Caption = 'Model';

            trigger OnValidate()
            var
                AutoMark: Record "Auto Mark";
                AutoModel: Record "Auto Model";
            begin
                if (rec.Mark <> '') and (rec.Model <> xRec.Model) then begin
                    AutoMark.Get(rec.Mark);
                    AutoModel.Get(rec.Mark, rec.Model);
                    rec.Name := AutoMark.Description + ' ' + AutoModel.Description;
                end;

            end;
        }
        field(40; "Date of Creation"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date of Creation';
        }
        field(50; "Civil Use Expiration Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Civil Use Expiration Date';
        }
        field(60; "TA Expiration Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'TA Expiration Date';
        }
        field(70; "Area Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
            Caption = 'Area Code';
        }
        field(80; "Rent Service"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Resource;
            Caption = 'Rent Service';

            trigger OnValidate()
            var
                ResourceData: Record Resource;
            begin
                ResourceData.Get(Rec."Rent Service");
                Rec."Price of Rent" := ResourceData."Unit Price";
            end;
        }
        field(90; "Price of Rent"; Decimal)
        {
            Caption = 'Price of Rent';
            FieldClass = FlowField;
            CalcFormula = lookup(Resource."Unit Price" where("No." = field("Rent Service")));
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    procedure GetNewAutoNoFromSeries(): Code[20]
    var
        NoSeriesManagement: Codeunit NoSeriesManagement;
        AutoSetup: Record "Auto Setup";
    begin
        AutoSetup.get();
        AutoSetup.TestField("Auto No. Series");
        exit(NoSeriesManagement.GetNextNo(AutoSetup."Auto No. Series", WorkDate(), true));
    end;
}
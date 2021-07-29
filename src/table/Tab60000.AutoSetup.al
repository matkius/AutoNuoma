table 60000 "Auto Setup"
{
    DataClassification = ToBeClassified;
    Caption = 'Auto Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary Key';
        }
        field(10; "Auto No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Auto No. Series';
        }
        field(20; "Rental Card No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Rent Card Serial';
        }
        field(30; "Accessory Area"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
            Caption = 'Accessory Area';
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        SetDefaultValues();
    end;

    procedure insertIfNotExist()
    begin
        if not Get() then begin
            Init();
            Insert(true);
        end;
    end;

    procedure SetDefaultValues()
    var
        AutoSetupManagement: Codeunit "Auto Setup Management";
        AutoNosCodeLbl: Label 'AUTO RENTALS';
        AutoNosDescriptionLbl: Label 'Auto Nos';
        AutoNosFirstLbl: Label 'AR0001';

        RentalCardCodeLbl: Label 'RENTAL CARD';
        RentalCardDescriptionLbl: Label 'Rental Card Serial Nos';
        RentalCardFirstLbl: Label 'RC0001';
    begin
        if "Auto No. Series" = '' then
            Rec."Auto No. Series" := AutoSetupManagement.NewNoSeries(AutoNosCodeLbl, AutoNosDescriptionLbl, AutoNosFirstLbl);
        if "Rental Card No. Series" = '' then
            Rec."Rental Card No. Series" := AutoSetupManagement.NewNoSeries(RentalCardCodeLbl, RentalCardDescriptionLbl, RentalCardFirstLbl);
    end;
}
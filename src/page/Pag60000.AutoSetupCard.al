page 60000 "Auto Setup Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Auto Setup";
    Caption = 'Auto Setup Card';
    InsertAllowed = false;
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Auto No. Series"; rec."Auto No. Series")
                {
                    ApplicationArea = All;
                    Caption = 'Auto No. Series';
                }
                field("Rental Card No. Series"; rec."Rental Card No. Series")
                {
                    ApplicationArea = All;
                    Caption = 'Rental Card No. Series';
                }
                field("Accessory Area"; rec."Accessory Area")
                {
                    ApplicationArea = All;
                    Caption = 'Accessory Area';
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.insertIfNotExist();
    end;
}
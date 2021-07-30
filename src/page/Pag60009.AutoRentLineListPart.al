page 60009 "Auto Rent Line ListPart"
{
    PageType = ListPart;
    UsageCategory = None;
    SourceTable = "Auto Rent Line";
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'Document No.';
                }
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Line No.';
                }
                field("Type"; rec."Type")
                {
                    ApplicationArea = All;
                    Caption = 'Type';
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.';

                    trigger OnValidate()
                    begin
                        if rec."Sum" <> xRec."Sum" then
                            CurrPage.Update();
                    end;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Quantity';

                    trigger OnValidate()
                    begin
                        if rec."Sum" <> xRec."Sum" then
                            CurrPage.Update();
                    end;
                }
                field(Price; rec.Price)
                {
                    ApplicationArea = All;
                    Caption = 'Price';
                }
                field("Sum"; rec."Sum")
                {
                    ApplicationArea = All;
                    Caption = 'Sum';
                }
            }
        }
    }
}
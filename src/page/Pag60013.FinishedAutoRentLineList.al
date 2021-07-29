page 60013 "Finished Auto Rent Line List"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Finished Auto Rent Line";
    Caption = 'Finished Auto Rent Line List';
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
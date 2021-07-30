page 60010 "Auto Rent Damage List"
{
    PageType = List;
    UsageCategory = None;
    AutoSplitKey = true;
    SourceTable = "Auto Rent Damage";

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
                field("Date"; rec."Date")
                {
                    ApplicationArea = All;
                    Caption = 'Date';
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                }
            }
        }
    }
}
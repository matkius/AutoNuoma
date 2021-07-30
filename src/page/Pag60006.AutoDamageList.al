page 60006 "Auto Damage List"
{
    PageType = List;
    UsageCategory = None;
    SourceTable = "Auto Damage";
    AutoSplitKey = true;
    Caption = 'Auto Damage List';
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Auto No."; rec."Auto No.")
                {
                    ApplicationArea = All;
                    TableRelation = Auto;
                    Caption = 'Auto No.';
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
                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                }
            }
        }
    }
}
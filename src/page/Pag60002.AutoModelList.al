page 60002 "Auto Model List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Model";
    Caption = 'Auto Model List';
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Mark Code"; rec."Mark Code")
                {
                    ApplicationArea = All;
                    Caption = 'Mark Code';
                }
                field("Code"; rec."Code")
                {
                    ApplicationArea = All;
                    Caption = 'Code';
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
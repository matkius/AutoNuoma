page 60001 "Auto Mark List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Mark";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Code"; rec."Code")
                {
                    ApplicationArea = All;
                    Caption = 'Code';
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Descriptiom';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ViewModels)
            {
                Caption = 'View Models';
                ApplicationArea = All;

                trigger OnAction()
                var
                    ContractVersionManagement: Codeunit "Auto Mark Management";
                begin
                    ContractVersionManagement.OpenModels(Rec);
                end;
            }
        }
    }
}
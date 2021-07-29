page 60011 "Finished Auto Rent Header List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Finished Auto Rent Header";
    CardPageId = "Finished Auto Rent Header Card";
    Caption = 'Finished Auto Rent Header';
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.';
                }
                field("Client No."; rec."Client No.")
                {
                    ApplicationArea = All;
                    Caption = 'Client No.';
                }
                field("Date"; rec."Date")
                {
                    ApplicationArea = All;
                    Caption = 'Date';
                }
                field("Auto No."; rec."Auto No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.';
                }
                field("Rent Start Date"; rec."Rent Start Date")
                {
                    ApplicationArea = All;
                    Caption = 'Rent Start Date';
                }
                field("Rent End Date"; rec."Rent End Date")
                {
                    ApplicationArea = All;
                    Caption = 'Rent End Date';
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
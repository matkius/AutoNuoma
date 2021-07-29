page 60007 "Auto Rent Header List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Rent Header";
    CardPageId = "Auto Rent Header Card";
    RefreshOnActivate = true;
    Caption = 'Auto Rent Header List';
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
                field("Drivers License"; rec."Drivers License")
                {
                    ApplicationArea = All;
                    Caption = 'Drivers License';
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
                field("Reservation Start Date"; rec."Rent Start Date")
                {
                    ApplicationArea = All;
                    Caption = 'Rent Start Date';
                }
                field("Reservation End Date"; rec."Rent End Date")
                {
                    ApplicationArea = All;
                    Caption = 'Rent End Date';
                }
                field("Sum"; rec."Sum")
                {
                    ApplicationArea = All;
                    Caption = 'Sum';
                }
                field("Status"; rec."Status")
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                }
            }
        }
    }
}
page 60012 "Finished Auto Rent Header Card"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Finished Auto Rent Header";
    Caption = 'Finished Auto Rent Header Card';
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
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
            part(RentLines; "Finished Auto Rent Line List")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");
            }
        }
        area(factboxes)
        {
            part("Drivers License"; "Finished License Picture")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
            }
        }
    }
}
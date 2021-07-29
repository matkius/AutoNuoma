page 60014 "Current Auto Reservation List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Auto Reservation";
    //SourceTableView = where field("Reservation Start Date") 
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Auto No."; rec."Auto No.")
                {
                    ApplicationArea = All;
                    Caption = 'Auto No.';
                }
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Line No.';
                    Editable = false;
                }
                field("Client No."; rec."Client No.")
                {
                    ApplicationArea = All;
                    Caption = 'Client No.';
                }
                field("Reservation Start Date"; rec."Reservation Start Date")
                {
                    ApplicationArea = All;
                    Caption = 'Reservation Start Date';
                }
                field("Reservation End Date"; rec."Reservation End Date")
                {
                    ApplicationArea = All;
                    Caption = 'Reservation End Date';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        rec.SetFilter("Reservation Start Date", '>%1', WorkDate());
    end;

    //use filter group 20
}
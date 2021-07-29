page 60003 "Auto Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Auto;
    Caption = 'Auto Card';
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.';
                    trigger OnAssistEdit()
                    begin
                        if rec."No." = '' then
                            rec."No." := rec.GetNewAutoNoFromSeries();
                    end;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Name';
                }
                field(Mark; rec.Mark)
                {
                    ApplicationArea = All;
                    Caption = 'Mark';
                }
                field(Model; rec.Model)
                {
                    ApplicationArea = All;
                    Caption = 'Model';

                }
                field("Date of Creation"; rec."Date of Creation")
                {
                    ApplicationArea = All;
                    Caption = 'Date of Creation';
                }
                field("Civil Use Expiration Date"; rec."Civil Use Expiration Date")
                {
                    ApplicationArea = All;
                    Caption = 'Civil Use Expiration Date';
                }
                field("TA Expiration Date"; rec."TA Expiration Date")
                {
                    ApplicationArea = All;
                    Caption = 'TA Expiration Date';
                }
                field("Area Code"; rec."Area Code")
                {
                    ApplicationArea = All;
                    Caption = 'Area Code';
                }
                field("Rent Service"; rec."Rent Service")
                {
                    ApplicationArea = All;
                    Caption = 'Rent Service';
                }
                field("Price of Rent"; rec."Price of Rent")
                {
                    ApplicationArea = All;
                    Caption = 'Price of Rent';

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ViewReservations)
            {
                Caption = 'View Reservations';
                ApplicationArea = All;

                trigger OnAction()
                var
                    AutoReservationManagement: Codeunit "Auto Management";
                begin
                    AutoReservationManagement.OpenReservations(Rec);
                end;
            }
            action(ViewDamages)
            {
                Caption = 'View Damages';
                ApplicationArea = All;

                trigger OnAction()
                var
                    AutoReservationManagement: Codeunit "Auto Management";
                begin
                    AutoReservationManagement.OpenAutoDamages(Rec);
                end;
            }
            action(RentHistoryReport)
            {
                Caption = 'Rent History Report';
                ApplicationArea = All;
                Image = AmountByPeriod;
                RunObject = report "Auto Rent History";
                trigger OnAction();
                begin

                end;
            }
        }
    }
}
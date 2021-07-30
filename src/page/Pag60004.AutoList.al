page 60004 "Auto List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Auto;
    CardPageId = "Auto Card";
    Caption = 'Auto List';
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
                trigger OnAction();
                var
                    auto: Record Auto;
                begin
                    auto.SetRange("No.", rec."No.");
                    Report.RunModal(Report::"Auto Rent History", true, true, auto);
                end;
            }
        }
    }
}
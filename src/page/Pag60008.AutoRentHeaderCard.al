page 60008 "Auto Rent Header Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Auto Rent Header";
    RefreshOnActivate = true;

    Caption = 'Auto Rent Header Card';
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
                    Editable = true;
                    Caption = 'No.';

                    trigger OnAssistEdit()
                    begin
                        if rec."No." = '' then
                            rec."No." := rec.GetNewRentNoFromSeries();
                    end;
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

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Reservation Start Date"; rec."Rent Start Date")
                {
                    ApplicationArea = All;
                    Caption = 'Rent Start Date';

                    // trigger OnDrillDown()
                    // var
                    //     //myInt: Integer;
                    // begin
                    //     SetFilter();
                    // end;
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
            part(RentLines; "Auto Rent Line ListPart")
            {
                UpdatePropagation = Both;
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");
            }
        }
        area(factboxes)
        {
            part("Drivers License"; "Drivers License Picture")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ViewDamages)
            {
                Caption = 'View Damages';
                ApplicationArea = All;

                trigger OnAction()
                var
                    AutoReservationManagement: Codeunit "Auto Rent Header Management";
                begin
                    AutoReservationManagement.OpenRentDamages(Rec);
                end;
            }

            action(RentAuto)
            {
                Caption = 'Rent Auto';
                ApplicationArea = All;
                Visible = rec.Status = rec.Status::Open;

                trigger OnAction()
                var
                    AutoReservationManagement: Codeunit "Auto Rent Header Management";
                begin
                    AutoReservationManagement.ChangeStatusToRented(Rec);
                end;
            }

            action(ReturnAuto)
            {
                Caption = 'Return Auto';
                ApplicationArea = All;
                Visible = rec.Status = rec.Status::Rented;

                trigger OnAction()
                var
                    ReturnAuto: Codeunit "Return Auto";
                begin
                    ReturnAuto.ReturnAuto(Rec);
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        aaa: Record "Auto Rent Line";
        killme: Integer;
    begin
        // if rec."No." = '' then
        //     rec."No." := rec.GetNewRentNoFromSeries();
        //killme := aaa.Count();
        //message('%1', killme);
        //aaa.DeleteAll();
    end;


}
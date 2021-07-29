codeunit 60003 "Auto Management"
{
    procedure OpenReservations(var Auto: Record "Auto")
    var
        AutoReservations: Record "Auto Reservation";
    begin
        AutoReservations.SetRange("Auto No.", Auto."No.");
        page.RunModal(0, AutoReservations);
    end;

    procedure OpenAutoDamages(var Auto: Record "Auto")
    var
        AutoDamages: Record "Auto Damage";
    begin
        AutoDamages.SetRange("Auto No.", Auto."No.");
        page.RunModal(0, AutoDamages);
    end;
}
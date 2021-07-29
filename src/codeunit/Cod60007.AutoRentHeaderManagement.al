codeunit 60007 "Auto Rent Header Management"
{
    procedure ChangeStatusToRented(var RentHeader: Record "Auto Rent Header")
    var
        Reservation: Record "Auto Reservation";
        ReservationNotFoundLbl: Label 'Reservation for specified customer, car and dates was not found';
    begin
        if RentHeader.Status = RentHeader.Status::Rented then
            exit;

        RentHeader.TestField("No.");
        RentHeader.TestField("Auto No.");
        RentHeader.TestField("Client No.");
        RentHeader.TestField("Rent Start Date");
        RentHeader.TestField("Rent End Date");

        // Reservation.SetRange("Auto No.", RentHeader."Auto No.");
        // Reservation.SetRange("Client No.", RentHeader."Client No.");
        // if Reservation.FindSet() then begin
        //     repeat
        //         if (Reservation."Reservation Start Date" = RentHeader."Rent Start Date") and (Reservation."Reservation End Date" = Reservation."Reservation End Date") then
        //             Reservation.Delete();
        //         break;
        //     until Reservation.Next() = 0;
        // end
        // else
        //     Error(ReservationNotFoundLbl);

        RentHeader.Status := RentHeader.Status::Rented;
        RentHeader.Modify();
    end;

    procedure OpenRentDamages(var Header: Record "Auto Rent Header")
    var
        RentDamages: Record "Auto Rent Damage";
    begin
        RentDamages.SetRange("Document No.", Header."No.");
        page.RunModal(0, RentDamages);
    end;



    // [EventSubscriber(ObjectType::Table, Database::"Auto Rent Line", 'OnAfterInsertEvent', '', false, false)]
    // local procedure UpdateSum_OnAfterInsertEvent(rec: Record "Auto Rent Line")
    // var
    //     Header: Record "Auto Rent Header";
    //     HeaderLines: Record "Auto Rent Line";
    // //cust: Record customer;
    // //aaa: Record "Company Information";
    // begin
    //     Message('ssssssssssssssss');

    //     Header.Get(rec."Document No.");
    //     HeaderLines.SetRange("Document No.", rec."Document No.");
    //     HeaderLines.CalcSums("Sum");
    //     Header."Sum" := HeaderLines."Sum";
    //     Header.Modify();
    // end;
}
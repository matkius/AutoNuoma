codeunit 60008 "Return Auto"
{
    procedure ReturnAuto(var Header: Record "Auto Rent Header")
    var
        HeaderLines: Record "Auto Rent Line";
        RentDamage: Record "Auto Rent Damage";

        FinishedHeader: Record "Finished Auto Rent Header";
        FinishedLine: Record "Finished Auto Rent Line";
        AutoDamage: Record "Auto Damage";

        AutoDamageSet: Record "Auto Damage";
        AutoDamageLastLineNo: Integer;

    begin
        if Header.Status = Header.Status::Open then
            exit;

        FinishedHeader.Init();
        FinishedHeader.TransferFields(Header);
        Header.CalcFields("Sum");
        FinishedHeader."Sum" := Header."Sum";
        FinishedHeader.Insert();

        if Header."Drivers License".HasValue then
            CopyPicture(Header, FinishedHeader);

        HeaderLines.SetRange("Document No.", Header."No.");
        if HeaderLines.FindSet() then
            repeat
                FinishedLine.Init();
                FinishedLine.TransferFields(HeaderLines);
                FinishedLine.Insert();
                HeaderLines.Delete();
            until HeaderLines.Next() = 0;

        AutoDamageLastLineNo := 0;
        AutoDamageSet.SetRange("Auto No.", Header."Auto No.");
        if AutoDamageSet.FindSet() then
            repeat
                if AutoDamageSet."Line No." > AutoDamageLastLineNo then
                    AutoDamageLastLineNo := AutoDamageSet."Line No.";
            until AutoDamageSet.Next() = 0;

        RentDamage.SetRange("Document No.", Header."No.");
        if RentDamage.FindSet() then
            repeat
                AutoDamage.Init();
                AutoDamage."Auto No." := Header."Auto No.";
                AutoDamage."Line No." := AutoDamageLastLineNo + 1;
                AutoDamageLastLineNo := AutoDamageLastLineNo + 1;
                AutoDamage."Date" := RentDamage."Date";
                AutoDamage.Description := RentDamage.Description;
                AutoDamage.Insert();
                RentDamage.Delete();
            until RentDamage.Next() = 0;

        Header.Delete();
    end;




    local procedure CopyPicture(var HeaderFrom: Record "Auto Rent Header"; var HeaderTo: Record "Finished Auto Rent Header")
    var
        TempNameValueBuffer: Record "Name/Value Buffer" temporary;
        FileManagement: Codeunit "File Management";
        ConfirmManagement: Codeunit "Confirm Management";
        ExportPath: Text;
    begin
        ExportPath := TemporaryPath + HeaderFrom."No." + Format(HeaderFrom."Drivers License".MediaId) + '.jpg';
        HeaderFrom."Drivers License".ExportFile(ExportPath);
        FileManagement.GetServerDirectoryFilesList(TempNameValueBuffer, TemporaryPath);
        TempNameValueBuffer.SetFilter(Name, StrSubstNo('%1*', ExportPath));
        TempNameValueBuffer.FindFirst;

        Clear(HeaderTo."Drivers License");
        HeaderTo."Drivers License".ImportFile(TempNameValueBuffer.Name, '');
        HeaderTo.Modify();
        if FileManagement.DeleteServerFile(TempNameValueBuffer.Name) then;
    end;


}
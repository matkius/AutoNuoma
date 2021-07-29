codeunit 60001 "Auto Mark Management"
{
    procedure OpenModels(var AutoMark: Record "Auto Mark")
    var
        AutoMarkModels: Record "Auto Model";
    begin
        AutoMarkModels.SetRange("Mark Code", AutoMark."Code");
        page.RunModal(0, AutoMarkModels);
    end;
}
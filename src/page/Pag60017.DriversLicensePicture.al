page 60017 "Drivers License Picture"
{
    Caption = 'Drivers License Picture';
    PageType = CardPart;
    SourceTable = "Auto Rent Header";

    layout
    {
        area(content)
        {
            field("Drivers License"; rec."Drivers License")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ImportPicture)
            {
                ApplicationArea = All;
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';
                Enabled = rec.Status = rec.Status::Open;

                trigger OnAction()
                var
                    FileManagement: Codeunit "File Management";
                    FileName: Text;
                    ClientFileName: Text;

                begin
                    rec.TestField("No.");
                    if rec."Client No." = '' then
                        Error(MustSpecifyCustomerErr);

                    if rec."Drivers License".HasValue then
                        if not Confirm(OverrideImageQst) then
                            exit;

                    FileName := FileManagement.UploadFile(SelectPictureTxt, ClientFileName);
                    if FileName = '' then
                        exit;

                    Clear(rec."Drivers License");
                    rec."Drivers License".ImportFile(FileName, ClientFileName);
                    if not rec.Modify(true) then
                        rec.Insert(true);


                    if FileManagement.DeleteServerFile(FileName) then;
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Image = Delete;
                ToolTip = 'Delete the record.';
                Enabled = rec.Status = rec.Status::Open;

                trigger OnAction()
                begin
                    rec.TestField("No.");

                    if not Confirm(DeleteImageQst) then
                        exit;

                    Clear(rec."Drivers License");
                    rec.Modify(true);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetEditableOnPictureActions;
    end;

    var
        Camera: Codeunit Camera;
        [InDataSet]
        CameraAvailable: Boolean;
        OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: Label 'Select a picture to upload';
        DeleteExportEnabled: Boolean;
        MustSpecifyCustomerErr: Label 'You must specify a customer before you can import a picture.';


    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := rec."Drivers License".HasValue;
    end;
}


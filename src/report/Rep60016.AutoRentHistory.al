report 60016 "Auto Rent History"
{
    UsageCategory = None;
    RDLCLayout = './src/reportlayouts/R60016.rdl';

    dataset
    {
        dataitem(Auto; Auto)
        {
            RequestFilterFields = "No.";
            column(No_; "No.")
            {

            }
            column(AutoMark; AutoMark)
            {

            }
            column(AutoModel; AutoModel)
            {

            }
            dataitem("Finished Auto Rent Header"; "Finished Auto Rent Header")
            {
                DataItemLink = "Auto No." = field("No.");
                DataItemTableView = sorting("No.");

                column(Rent_Start_Date; "Rent Start Date")
                {

                }
                column(Rent_End_Date; "Rent End Date")
                {

                }
                column(Customer_Name; CustomerName)
                {

                }
                column(Cost; "Sum")
                {

                }
                trigger OnPreDataItem()
                begin
                    if FromDate <> 0D then
                        SetFilter("Rent Start Date", '>%1', FromDate);
                    if ToDate <> 0D then
                        SetFilter("Rent End Date", '<%1', ToDate);
                end;

                trigger OnAfterGetRecord()
                var
                    cust: Record Customer;
                begin
                    cust.Get("Client No.");
                    CustomerName := cust.Name;
                end;

            }
            trigger OnAfterGetRecord()
            var
                marks: Record "Auto Mark";
                models: Record "Auto Model";
            begin
                marks.Get(Mark);
                models.Get(Mark, Model);
                AutoMark := marks.Description;
                AutoModel := models.Description;
            end;
        }
    }

    requestpage

    {

        layout

        {

            area(Content)

            {

                group(GroupName)
                {
                    Caption = 'Date Filter';
                    field(FromDate; FromDate)
                    {
                        Caption = 'Date From';
                        ApplicationArea = All;
                    }
                    field(ToDate; ToDate)
                    {
                        Caption = 'Date To';
                        ApplicationArea = All;
                    }
                }
            }
        }


        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    var
        FromDate: Date;
        ToDate: Date;
        AutoMark: Text[20];
        AutoModel: Text[50];
        CustomerName: Text[100];
}
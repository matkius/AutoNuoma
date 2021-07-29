report 60015 "Auto Rent Report"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    RDLCLayout = './src/reportlayouts/R60015.rdl';
    dataset
    {
        dataitem(RentHeader; "Auto Rent Header")
        {
            column(No_; "No.") { }
            column(Auto_No_; "Auto No.")
            {

            }
            column(Auto_Mark; AutoMark)
            {

            }
            column(Auto_Model; AutoModel)
            {

            }
            column(TimeFrame; TimeFrame)
            {

            }
            column(Customer_Name; CustomerName)
            {

            }
            dataitem(HeaderLine; "Auto Rent Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.");
                column(Rent_Item; RentItem)
                {

                }
                column(Price; Price)
                {

                }
                column(Quantity; Quantity)
                {

                }
                column("Sum"; "Sum")
                {

                }
                column(RentCost; RentCost)
                {

                }
                column(AdditionalServiceCost; AdditionalServiceCost)
                {

                }
                trigger OnPreDataItem()
                begin
                    RentCost := 0;
                    AdditionalServiceCost := 0;
                end;

                trigger OnAfterGetRecord()
                var
                    Items: Record Item;
                    Resources: Record Resource;
                begin
                    if "Type" = "Type"::Item then begin
                        Items.Get("No.");
                        RentItem := Items.Description;
                    end else begin
                        Resources.Get("No.");
                        RentItem := Resources.Name;
                    end;

                    if "Line No." = 1 then begin
                        RentCost := "Sum";
                        AdditionalServiceCost := 0;
                    end else begin
                        RentCost := 0;
                        AdditionalServiceCost := "Sum";
                    end;

                end;
            }

            trigger OnAfterGetRecord()
            var
                Auto: Record Auto;
                Mark: Record "Auto Mark";
                Model: Record "Auto Model";
                Cust: Record Customer;
            begin
                Auto.Get("Auto No.");
                Mark.Get(Auto.Mark);
                Model.Get(Auto.Mark, Auto.Model);
                Cust.Get("Client No.");
                CustomerName := Cust.Name;
                AutoMark := Mark.Description;
                AutoModel := Model.Description;
                TimeFrame := Format("Rent Start Date") + ' <-> ' + Format("Rent End Date");
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
        AutoMark: Text[20];
        AutoModel: Text[50];
        TimeFrame: Text[50];
        CustomerName: Text[100];
        RentItem: Text[100];
        RentCost: Decimal;
        AdditionalServiceCost: Decimal;
}
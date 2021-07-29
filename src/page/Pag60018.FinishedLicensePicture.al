page 60018 "Finished License Picture"
{
    Caption = 'Drivers License';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = CardPart;
    SourceTable = "Finished Auto Rent Header";

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
}


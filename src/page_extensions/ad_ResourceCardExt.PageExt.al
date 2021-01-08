pageextension 50000 ad_ResourceCardExt extends "Resource Card"
{
    layout
    {
        addafter(Type)
        {
            field(Internal; Rec.Internal)
            {
                ApplicationArea = All;
            }
        }
        addafter("Base Unit of Measure")
        {
            field("Quantity Per Day"; Rec."Quantity Per Day")
            {
                ApplicationArea = All;
            }
        }
        addlast(content)
        {
            group(Room)
            {
                Caption = 'Room';

                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

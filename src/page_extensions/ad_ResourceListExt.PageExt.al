pageextension 50001 ad_ResourceListExt extends "Resource List"
{
    layout
    {
        addafter(Type)
        {
            field(Internal; Rec.Internal)
            {
                ApplicationArea = All;
            }

            field("Maximum Participants"; Rec."Maximum Participants")
            {
                ApplicationArea = All;
                Visible = ShowMaxParticipants;
            }
        }
        modify(Type)
        {
            Visible = ShowType;
        }
    }

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(3);
        ShowType := Rec.GetFilter(Type) = '';
        ShowMaxParticipants := Rec.GetFilter(Type) = FORMAT(Rec.Type::Machine);
        Rec.FilterGroup(0);
    end;

    var
        [InDataSet]
        ShowType: Boolean;
        [InDataSet]
        ShowMaxParticipants: Boolean;
}

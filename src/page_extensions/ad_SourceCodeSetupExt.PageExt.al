pageextension 50002 ad_SourceCodeSetupExt extends "Source Code Setup"
{
    layout
    {
        addlast(content)
        {
            group("Seminar Management")
            {
                Caption = 'Seminar Management';
                field(Seminar; Rec.Seminar)
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}

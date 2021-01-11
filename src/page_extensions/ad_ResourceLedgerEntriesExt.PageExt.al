pageextension 50003 ad_ResourceLedgerEntriesExt extends "Resource Ledger Entries"
{
    layout
    {
        addbefore("Job No.")
        {
            field("Seminar No."; Rec."Seminar No")
            {
                ApplicationArea = All;
            }
            field("Seminar Registration No."; Rec."Seminar Registration No.")
            {
                ApplicationArea = All;
            }

        }
    }
}

tableextension 50002 ad_ResLedgerEntryExt extends "Res. Ledger Entry"
{
    fields
    {
        field(50000; "Seminar No."; Code[20])
        {
            Caption = 'Seminar No';
            DataClassification = CustomerContent;
            TableRelation = ad_Seminar;
        }
        field(50001; "Seminar Registration No."; Code[20])
        {
            Caption = 'Seminar Registration No.';
            DataClassification = CustomerContent;
            TableRelation = ad_PostedSeminarRegHeader;
        }
    }
}

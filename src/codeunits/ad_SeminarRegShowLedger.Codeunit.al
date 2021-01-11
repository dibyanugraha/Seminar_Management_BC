codeunit 50004 ad_SeminarRegShowLedger
{
    TableNo = ad_SeminarRegister;

    trigger OnRun()
    begin
        SeminarLedgerEntry.SetRange("Entry No.", Rec."From Entry No.", Rec."To Entry No.");
        PAGE.Run(PAGE::ad_SeminarLedgerEntries, SeminarLedgerEntry);
    end;

    var
        SeminarLedgerEntry: Record ad_SeminarLedgerEntry;
}

codeunit 50001 ad_EventSubResJnlPostLine
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Res. Jnl.-Post Line", 'OnBeforeResLedgEntryInsert', '', false, false)]
    local procedure OnBeforeResLedgEntryInsert(
        ResJournalLine: Record "Res. Journal Line";
        var ResLedgerEntry: Record "Res. Ledger Entry"
    )
    begin
        ResLedgerEntry."Seminar No." := ResJournalLine."Seminar No.";
        ResLedgerEntry."Seminar Registration No." := ResJournalLine."Seminar Registration No.";
    end;
}

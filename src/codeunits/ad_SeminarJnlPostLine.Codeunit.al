codeunit 50032 ad_SeminarJnlPostLine
{
    TableNo = ad_SeminarJournalLine;

    trigger OnRun()
    begin

    end;

    var
        SeminarJnlLine: Record ad_SeminarJournalLine;
        SeminarLedgerEntry: Record ad_SeminarLedgerEntry;
        SeminarRegister: Record ad_SeminarRegister;
        SeminarJnlCheckLine: Codeunit ad_SeminarJnlCheckLine;
        NextEntryNo: Integer;

    PROCEDURE RunWithCheck(VAR SeminarJnlLine2: Record ad_SeminarJournalLine)
    BEGIN
        SeminarJnlLine.COPY(SeminarJnlLine2);
        Code;
        SeminarJnlLine2 := SeminarJnlLine;
    END;


    PROCEDURE Code()
    BEGIN
        IF SeminarJnlLine.EmptyLine THEN
            EXIT;

        SeminarJnlCheckLine.RunCheck(SeminarJnlLine);

        IF NextEntryNo = 0 THEN BEGIN
            SeminarLedgerEntry.LOCKTABLE;
            IF SeminarLedgerEntry.FINDLAST THEN
                NextEntryNo := SeminarLedgerEntry."Entry No.";
            NextEntryNo := NextEntryNo + 1;
        END;

        IF SeminarJnlLine."Document Date" = 0D THEN
            SeminarJnlLine."Document Date" := SeminarJnlLine."Posting Date";

        IF SeminarRegister."No." = 0 THEN BEGIN
            SeminarRegister.LOCKTABLE;
            IF (NOT SeminarRegister.FINDLAST) OR (SeminarRegister."To Entry No." <> 0) THEN BEGIN
                SeminarRegister.INIT;
                SeminarRegister."No." := SeminarRegister."No." + 1;
                SeminarRegister."From Entry No." := NextEntryNo;
                SeminarRegister."To Entry No." := NextEntryNo;
                SeminarRegister."Creation Date" := TODAY;
                SeminarRegister."Source Code" := SeminarJnlLine."Source Code";
                SeminarRegister."Journal Batch Name" := SeminarJnlLine."Journal Batch Name";
                SeminarRegister."User ID" := USERID;
                SeminarRegister.INSERT;
            END;
        END;
        SeminarRegister."To Entry No." := NextEntryNo;
        SeminarRegister.MODIFY;

        SeminarLedgerEntry.INIT;
        SeminarLedgerEntry."Seminar No." := SeminarJnlLine."Seminar No.";
        SeminarLedgerEntry."Posting Date" := SeminarJnlLine."Posting Date";
        SeminarLedgerEntry."Document Date" := SeminarJnlLine."Document Date";
        SeminarLedgerEntry."Entry Type" := SeminarJnlLine."Entry Type";
        SeminarLedgerEntry."Document No." := SeminarJnlLine."Document No.";
        SeminarLedgerEntry.Description := SeminarJnlLine.Description;
        SeminarLedgerEntry."Bill-to Customer No." := SeminarJnlLine."Bill-to Customer No.";
        SeminarLedgerEntry."Charge Type" := SeminarJnlLine."Charge Type";
        SeminarLedgerEntry.Type := SeminarJnlLine.Type;
        SeminarLedgerEntry.Quantity := SeminarJnlLine.Quantity;
        SeminarLedgerEntry."Unit Price" := SeminarJnlLine."Unit Price";
        SeminarLedgerEntry."Total Price" := SeminarJnlLine."Total Price";
        SeminarLedgerEntry."Participant Contact No." := SeminarJnlLine."Participant Contact No.";
        SeminarLedgerEntry."Participant Name" := SeminarJnlLine."Participant Name";
        SeminarLedgerEntry.Chargeable := SeminarJnlLine.Chargeable;
        SeminarLedgerEntry."Room Resource No." := SeminarJnlLine."Room Resource No.";
        SeminarLedgerEntry."Instructor Resource No." := SeminarJnlLine."Instructor Resource No.";
        SeminarLedgerEntry."Starting Date" := SeminarJnlLine."Starting Date";
        SeminarLedgerEntry."Seminar Registration No." := SeminarJnlLine."Seminar Registration No.";
        SeminarLedgerEntry."Res. Ledger Entry No." := SeminarJnlLine."Res. Ledger Entry No.";
        SeminarLedgerEntry."Source Type" := SeminarJnlLine."Source Type";
        SeminarLedgerEntry."Source No." := SeminarJnlLine."Source No.";
        SeminarLedgerEntry."Journal Batch Name" := SeminarJnlLine."Journal Batch Name";
        SeminarLedgerEntry."Source Code" := SeminarJnlLine."Source Code";
        SeminarLedgerEntry."Reason Code" := SeminarJnlLine."Reason Code";
        SeminarLedgerEntry."No. Series" := SeminarJnlLine."Posting No. Series";
        SeminarLedgerEntry."User ID" := USERID;
        SeminarLedgerEntry."Entry No." := NextEntryNo;
        SeminarLedgerEntry.INSERT;
        NextEntryNo := NextEntryNo + 1;
    END;
}

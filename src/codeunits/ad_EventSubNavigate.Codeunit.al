codeunit 50098 ad_EventSubNavigate
{
    [EventSubscriber(ObjectType::Page, Page::Navigate, 'OnAfterNavigateFindRecords', '', false, false)]
    local procedure OnAfterNavigateFindRecords(
        sender: Page Navigate;
        var DocumentEntry: Record "Document Entry";
        DocNoFilter: Text;
        PostingDateFilter: Text
    )
    begin
        IF PostedSeminarRegHeader.ReadPermission then begin
            PostedSeminarRegHeader.RESET;
            PostedSeminarRegHeader.SETFILTER("No.", DocNoFilter);
            PostedSeminarRegHeader.SETFILTER("Posting Date", PostingDateFilter);
            sender.InsertIntoDocEntry(DocumentEntry,
                DATABASE::ad_PostedSeminarRegHeader,
                0, PostedSeminarRegHeader.TableCaption,
                PostedSeminarRegHeader.Count);
        end;

        IF SeminarLedgEntry.ReadPermission then begin
            SeminarLedgEntry.RESET;
            SeminarLedgEntry.SetCurrentKey("Document No.", "Posting Date");
            SeminarLedgEntry.SETFILTER("Document No.", DocNoFilter);
            SeminarLedgEntry.SETFILTER("Posting Date", PostingDateFilter);
            sender.InsertIntoDocEntry(DocumentEntry,
                DATABASE::ad_SeminarLedgerEntry,
                0, SeminarLedgEntry.TableCaption,
                SeminarLedgEntry.Count);
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::Navigate, 'OnAfterNavigateShowRecords', '', false, false)]
    local procedure OnAfterNavigateShowRecords(
        TableID: Integer;
        DocNoFilter: Text;
        PostingDateFilter: Text
    )
    begin
        case TableID of
            DATABASE::ad_PostedSeminarRegHeader:
                PAGE.RUN(0, PostedSeminarRegHeader);
            DATABASE::ad_SeminarLedgerEntry:
                PAGE.RUN(0, SeminarLedgEntry);
        end;
    end;

    var
        [SecurityFiltering(SecurityFilter::Filtered)]
        PostedSeminarRegHeader: Record ad_PostedSeminarRegHeader;
        [SecurityFiltering(SecurityFilter::Filtered)]
        SeminarLedgEntry: Record ad_SeminarLedgerEntry;
}

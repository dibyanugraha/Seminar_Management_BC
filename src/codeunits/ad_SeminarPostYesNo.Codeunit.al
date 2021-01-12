codeunit 50001 ad_SeminarPostYesNo
{
    TableNo = ad_SeminarRegistrationHeader;

    trigger OnRun()
    begin
        SeminarRegHeader.COPY(Rec);
        Code;
        Rec := SeminarRegHeader;
    end;

    var
        SeminarRegHeader: Record ad_SeminarRegistrationHeader;
        SeminarPost: Codeunit ad_SeminarPost;
        ContinuePostingQst: Label 'Continue to post Seminar Registration No.: %1?';

    local procedure "Code"();
    begin
        if NOT Confirm(ContinuePostingQst, FALSE, SeminarRegHeader."No.") then
            exit;
        SeminarPost.Run(SeminarRegHeader);
        COMMIT;
    end;
}

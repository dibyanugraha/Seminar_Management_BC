codeunit 50002 ad_SeminarRegistrationPrinted
{
    TableNo = ad_SeminarRegistrationHeader;

    trigger OnRun()
    begin
        Rec.Find();
        Rec."No. Printed" := Rec."No. Printed" + 1;
        Rec.Modify();
        Commit();
    end;
}

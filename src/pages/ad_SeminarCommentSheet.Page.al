page 50006 ad_SeminarCommentSheet
{
    Caption = 'Seminar Comment Sheet';
    PageType = List;
    SourceTable = ad_SeminarCommentLine;
    UsageCategory = None;
    MultipleNewLines = true;
    LinksAllowed = false;
    DelayedInsert = true;
    DataCaptionFields = "No.";
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetUpNewLine();
    end;
}

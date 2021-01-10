page 50007 ad_SeminarCommentList
{
    Caption = 'Seminar Comment List';
    PageType = List;
    SourceTable = ad_SeminarCommentLine;
    UsageCategory = None;
    Editable = false;
    LinksAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
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
}
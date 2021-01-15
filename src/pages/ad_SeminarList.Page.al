page 50001 ad_SeminarList
{
    ApplicationArea = All;
    Caption = 'Seminar List';
    PageType = List;
    SourceTable = ad_Seminar;
    UsageCategory = Lists;
    Editable = false;
    CardPageId = ad_SeminarCard;

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
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Seminar Duration"; Rec."Seminar Duration")
                {
                    ApplicationArea = All;
                }
                field("Seminar Price"; Rec."Seminar Price")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }
    actions
    {
        area(Creation)
        {
            action("Seminar Re&gistration")
            {
                Caption = 'Seminar Re&gistration';
                ApplicationArea = All;
                Image = NewTimesheet;
                Promoted = true;
                PromotedCategory = New;
                RunObject = page ad_SeminarRegistration;
                RunPageLink = "Seminar No." = field("No.");
                RunPageMode = Create;
            }
        }
        area(Navigation)
        {
            group("&Seminar")
            {
                Caption = '&Seminar';
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    ApplicationArea = All;
                    Image = WarrantyLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page ad_SeminarLedgerEntries;
                    RunPageLink = "Seminar No." = field("No.");
                }
                action("C&omments")
                {
                    Caption = 'C&omments';
                    Image = Comment;
                    RunObject = page "Comment Sheet";
                    RunPageLink = "Table Name" = const(Seminar), "No." = field("No.");
                }
            }
            group("&Registration")
            {
                Caption = '&Registration';
                Image = RegisteredDocs;
                action("&Registrations")
                {
                    Caption = '&Registrations';
                    ApplicationArea = All;
                    Image = Timesheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page ad_SeminarRegistrationList;
                    RunPageLink = "Seminar No." = field("No.");
                }
            }
        }
    }
}

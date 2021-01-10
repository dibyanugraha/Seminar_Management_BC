page 50022 ad_SeminarRegisters
{
    Editable = false;
    ApplicationArea = All;
    Caption = 'Seminar Registers';
    PageType = List;
    SourceTable = ad_SeminarRegister;
    UsageCategory = History;

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
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                }
                field("From Entry No."; Rec."From Entry No.")
                {
                    ApplicationArea = All;
                }
                field("To Entry No."; Rec."To Entry No.")
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
        area(Navigation)
        {
            group(Register)
            {
                Image = Register;
                action("Seminar Ledger")
                {
                    ApplicationArea = All;
                    Image = WarrantyLedger;
                    RunObject = codeunit ad_SeminarRegShowLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                }
            }
        }
    }

}

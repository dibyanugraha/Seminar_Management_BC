table 50000 ad_Seminar
{
    Caption = 'Seminar';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "No." = xRec."No." then
                    exit;

                SeminarSetup.Get();
                NoSeriesMgt.TestManual(SeminarSetup."Seminar Nos.");
                "No. Series" := '';
            end;
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(3; "Seminar Duration"; Decimal)
        {
            Caption = 'Seminar Duration';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 1;
        }
        field(4; "Minimum Participants"; Integer)
        {
            Caption = 'Minimum Participants';
            DataClassification = CustomerContent;
        }
        field(5; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
            DataClassification = CustomerContent;
        }
        field(6; "Search Name"; Code[50])
        {
            Caption = 'Search Name';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if ("Search Name" = UpperCase(xRec.Name))
                    or ("Search Name" = '') then begin
                    "Search Name" := Name;
                end;
            end;
        }
        field(7; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = CustomerContent;
        }
        //  last modified field was omitted because
        //  https://docs.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-table-system-fields#audit
        field(9; Comment; Boolean)
        {
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula =
                exist("Comment Line"
                    where("Table Name" = const(Seminar),
                        "No." = field("No.")));
        }
        field(10; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price';
            DataClassification = CustomerContent;
            AutoFormatType = 1;
        }
        field(11; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Product Posting Group";

            trigger OnValidate()
            begin
                if xRec."Gen. Prod. Posting Group" = "Gen. Prod. Posting Group" then
                    exit;
                if GenProdPostingGroup.ValidateVatProdPostingGroup(GenProdPostingGroup, "VAT Prod. Posting Group") then
                    Validate("VAT Prod. Posting Group", GenProdPostingGroup."Def. VAT Prod. Posting Group");
            end;
        }
        field(12; "VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group';
            DataClassification = CustomerContent;
            TableRelation = "VAT Product Posting Group";
        }
        field(13; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Search; "Search Name") { }
    }

    var
        SeminarSetup: Record ad_SeminarSetup;
        CommentLine: Record "Comment Line";
        GenProdPostingGroup: Record "Gen. Product Posting Group";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        if "No." <> '' then
            exit;

        SeminarSetup.Get();
        SeminarSetup.TestField("Seminar Nos.");
        NoSeriesMgt.InitSeries(
            SeminarSetup."Seminar Nos.",
            xRec."No. Series", 0D, "No.", "No. Series");
    end;

    trigger OnDelete()
    begin
        CommentLine.Reset();
        CommentLine.SetRange("Table Name", CommentLine."Table Name"::Seminar);
        CommentLine.SetRange("No.", "No.");
        CommentLine.DeleteAll();
    end;

    procedure AssistEdit(OldSeminar: Record ad_Seminar): Boolean
    var
        Seminar: Record ad_Seminar;
    begin
        Seminar := Rec;
        SeminarSetup.Get();
        SeminarSetup.TESTFIELD("Seminar Nos.");
        if NoSeriesMgt.SelectSeries(SeminarSetup."Seminar Nos.",
            xRec."No. Series", "No. Series") then begin
            NoSeriesMgt.SetSeries("No.");
            Rec := Seminar;
            exit(true);
        end;
    end;
}
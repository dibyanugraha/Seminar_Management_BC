table 50010 ad_SeminarRegistrationHeader
{
    Caption = 'Seminar Registration Header';
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
                SeminarSetup.TestField("Seminar Registration Nos.");
                NoSeriesMgt.TestManual(SeminarSetup."Seminar Registration Nos.");
                "No. Series" := '';
            end;
        }
        field(2; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Starting Date" <> xRec."Starting Date" then
                    TestField(Status, Status::Planning);
            end;
        }
        field(3; "Seminar No."; Code[20])
        {
            Caption = 'Seminar No.';
            DataClassification = CustomerContent;
            TableRelation = ad_Seminar where(Blocked = const(false));
        }
        field(4; "Seminar Name"; Text[100])
        {
            Caption = 'Seminar Name';
            DataClassification = CustomerContent;
        }
        field(5; "Instructor Resource No."; Code[20])
        {
            Caption = 'Instructor Resource No.';
            DataClassification = CustomerContent;
            TableRelation = Resource where(Type = const(Person));
        }
        field(6; "Instructor Name"; Text[100])
        {
            Caption = 'Instructor Name';
            DataClassification = CustomerContent;
        }
        field(7; Status; Enum ad_SeminarRegistrationStatus)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(8; Duration; Decimal)
        {
            Caption = 'Duration';
            DataClassification = CustomerContent;
        }
        field(9; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
            DataClassification = CustomerContent;
        }
        field(10; "Minimum Participants"; Integer)
        {
            Caption = 'Minimum Participants';
            DataClassification = CustomerContent;
        }
        field(11; "Room Resource No."; Code[20])
        {
            Caption = 'Room Resource No.';
            DataClassification = CustomerContent;
            TableRelation = Resource where(Type = const(Room));
        }
        field(12; "Room Name"; Text[100])
        {
            Caption = 'Room Name';
            DataClassification = CustomerContent;
        }
        field(13; "Room Address"; Text[50])
        {
            Caption = 'Room Address';
            DataClassification = CustomerContent;
        }
        field(14; "Room Address 2"; Text[50])
        {
            Caption = 'Room Address 2';
            DataClassification = CustomerContent;
        }
        field(15; "Room Post Code"; Code[20])
        {
            Caption = 'Room Post Code';
            DataClassification = CustomerContent;
            TableRelation = "Post Code";
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode("Room City",
                    "Room Post Code",
                    "Room County",
                    "Room Country/Reg. Code",
                    (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(16; "Room City"; Text[50])
        {
            Caption = 'Room City';
            DataClassification = CustomerContent;
        }
        field(17; "Room Country/Reg. Code"; Code[10])
        {
            Caption = 'Room Country/Reg. Code';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }
        field(18; "Room County"; Text[30])
        {
            Caption = 'Room County';
            DataClassification = CustomerContent;
        }
        field(19; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price';
            DataClassification = CustomerContent;
        }
        field(20; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Product Posting Group";
        }
        field(21; "VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group';
            DataClassification = CustomerContent;
            TableRelation = "VAT Product Posting Group";
        }
        field(22; Comment; Boolean)
        {
            Caption = 'Comment';
            DataClassification = CustomerContent;
        }
        field(23; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(24; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = CustomerContent;
        }
        field(25; "Reason Code"; Code[20])
        {
            Caption = 'Reason Code';
            DataClassification = CustomerContent;
            TableRelation = "Reason Code";
        }
        field(26; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(27; "Posting No. Series"; Code[20])
        {
            Caption = 'Posting No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                if "Posting No. Series" = '' then
                    exit;
                TestField("Posting No.", '');

                SeminarSetup.Get();
                SeminarSetup.TestField("Seminar Registration Nos.");
                SeminarSetup.TestField("Posted Seminar Reg. Nos.");
                NoSeriesMgt.TestSeries(SeminarSetup."Posted Seminar Reg. Nos.", "Posting No. Series");
            end;

            trigger OnLookup()
            begin
                SeminarRegHeader := Rec;
                SeminarSetup.Get();
                SeminarSetup.TestField("Seminar Registration Nos.");
                SeminarSetup.TestField("Posted Seminar Reg. Nos.");
                if NoSeriesMgt.LookupSeries(SeminarSetup."Posted Seminar Reg. Nos.", "Posting No. Series") then
                    Validate("Posting No. Series");

                Rec := SeminarRegHeader;
            end;
        }
        field(28; "Posting No."; Code[20])
        {
            Caption = 'Posting No.';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Index2; "Room Resource No.")
        {
            SumIndexFields = Duration;
        }
    }
    var
        SeminarSetup: Record ad_SeminarSetup;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PostCode: Record "Post Code";
        Seminar: Record ad_Seminar;
        SeminarRegHeader: Record ad_SeminarRegistrationHeader;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SeminarSetup.Get();
            SeminarSetup.TestField("Seminar Registration Nos.");
            NoSeriesMgt.InitSeries(SeminarSetup."Seminar Registration Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        END;
        InitRecord;
    end;

    trigger OnDelete()
    begin
        TestField(Status, Status::Cancelled);
    end;

    procedure InitRecord()
    begin
        if "Posting Date" = 0D then
            "Posting Date" := WorkDate();

        "Document Date" := WorkDate();

        SeminarSetup.Get();
        SeminarSetup.TestField("Posted Seminar Reg. Nos.");
        NoSeriesMgt.SetDefaultSeries("Posting No. Series", SeminarSetup."Posted Seminar Reg. Nos.");
    end;

    procedure AssistEdit(OldSeminarRegHeader: Record ad_SeminarRegistrationHeader): Boolean
    begin
        SeminarRegHeader := Rec;
        SeminarSetup.Get();
        SeminarSetup.TestField("Seminar Registration Nos.");
        if not NoSeriesMgt.SelectSeries(
            SeminarSetup."Seminar Registration Nos.",
            OldSeminarRegHeader."No. Series", "No. Series") then
            exit(false);

        SeminarSetup.Get();
        SeminarSetup.TestField("Seminar Registration Nos.");
        NoSeriesMgt.SetSeries("No.");
        Rec := SeminarRegHeader;
        exit(TRUE);
    end;
}

table 50011 ad_SeminarRegistrationLine
{
    Caption = 'Seminar Registration Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer where(Blocked = const(" "));

            trigger OnValidate()
            begin
                TestField(Registered, false);
            end;
        }
        field(4; "Participant Contact No."; Code[20])
        {
            Caption = 'Participant Contact No.';
            DataClassification = CustomerContent;
        }
        field(5; "Participant Name"; Text[100])
        {
            Caption = 'Participant Name';
            DataClassification = CustomerContent;
        }
        field(6; "Registration Date"; Date)
        {
            Caption = 'Registration Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "To Invoice"; Boolean)
        {
            Caption = 'To Invoice';
            DataClassification = CustomerContent;
            InitValue = true;
        }
        field(8; Participated; Boolean)
        {
            Caption = 'Participated';
            DataClassification = CustomerContent;
        }
        field(9; "Confirmation Date"; Date)
        {
            Caption = 'Confirmation Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(10; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price';
            DataClassification = CustomerContent;
            AutoFormatType = 2;

            trigger OnValidate()
            begin
                Validate("Line Discount %");
            end;
        }
        field(11; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
            DataClassification = CustomerContent;
            MinValue = 0;
            MaxValue = 100;
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                IF "Seminar Price" = 0 THEN BEGIN
                    "Line Discount Amount" := 0;
                END ELSE BEGIN
                    GLSetup.GET;
                    "Line Discount Amount" := ROUND("Line Discount %" * "Seminar Price" * 0.01, GLSetup."Amount Rounding Precision");
                END;
                UpdateAmount;
            end;
        }
        field(12; "Line Discount Amount"; Decimal)
        {
            Caption = 'Line Discount Amount';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                IF "Seminar Price" = 0 THEN BEGIN
                    "Line Discount %" := 0;
                END ELSE BEGIN
                    GLSetup.GET;
                    "Line Discount %" := ROUND("Line Discount Amount" / "Seminar Price" * 100, GLSetup."Amount Rounding Precision");
                END;
                UpdateAmount;
            end;
        }
        field(13; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TESTFIELD("Bill-to Customer No.");
                TESTFIELD("Seminar Price");
                GLSetup.GET;
                Amount := ROUND(Amount, GLSetup."Amount Rounding Precision");
                "Line Discount Amount" := "Seminar Price" - Amount;
                IF "Seminar Price" = 0 THEN BEGIN
                    "Line Discount %" := 0;
                END ELSE BEGIN
                    "Line Discount %" := ROUND("Line Discount Amount" / "Seminar Price" * 100, GLSetup."Amount Rounding Precision");
                END;
            end;
        }
        field(14; Registered; Boolean)
        {
            Caption = 'Registered';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        GetSeminarRegHeader;
        "Registration Date" := WORKDATE;
        "Seminar Price" := SeminarRegHeader."Seminar Price";
        Amount := SeminarRegHeader."Seminar Price";
    end;

    trigger OnDelete()
    begin
        TestField(Registered, false);
    end;

    var
        GLSetup: Record "General Ledger Setup";
        SeminarRegHeader: Record ad_SeminarRegistrationHeader;

    PROCEDURE GetSeminarRegHeader();
    BEGIN
        IF SeminarRegHeader."No." <> "Document No." THEN BEGIN
            SeminarRegHeader.GET("Document No.");
        END;
    END;

    PROCEDURE CalculateAmount();
    BEGIN
        Amount := ROUND(("Seminar Price" / 100) * (100 - "Line Discount %"));
    END;

    PROCEDURE UpdateAmount();
    BEGIN
        GLSetup.GET;
        Amount := ROUND("Seminar Price" - "Line Discount Amount", GLSetup."Amount Rounding Precision");
    END;
}

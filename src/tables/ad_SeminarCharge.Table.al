table 50012 ad_SeminarCharge
{
    Caption = 'ad_SeminarCharge';
    DataClassification = CustomerContent;
    LookupPageId = ad_SeminarCharges;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = ad_SeminarRegistrationHeader;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; Type; Enum ad_SeminarChargeType)
        {
            Caption = 'Type';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Type = xRec.Type then
                    exit;

                Description := '';
            end;
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            TableRelation =
                if (Type = const(Resource)) Resource where(Type = const(Person), Blocked = const(false))
            else
            if (Type = const("G/L Account")) "G/L Account" where(Blocked = const(false), "Direct Posting" = const(false));

            trigger OnValidate()
            begin
                case Type of
                    Type::Resource:
                        begin
                            Resource.GET("No.");
                            Resource.TESTFIELD(Blocked, FALSE);
                            Resource.TestField(Type, Resource.Type::Person);
                            Resource.TESTFIELD("Gen. Prod. Posting Group");
                            Description := Resource.Name;
                            "Gen. Prod. Posting Group" := Resource."Gen. Prod. Posting Group";
                            "VAT Prod. Posting Group" := Resource."VAT Prod. Posting Group";
                            "Unit of Measure Code" := Resource."Base Unit of Measure";
                            "Unit Price" := Resource."Unit Price";
                        end;
                    Type::"G/L Account":
                        begin
                            GLAccount.GET("No.");
                            GLAccount.CheckGLAcc();
                            GLAccount.TESTFIELD("Direct Posting", TRUE);
                            Description := GLAccount.Name;
                            "Gen. Prod. Posting Group" := GLAccount."Gen. Bus. Posting Group";
                            "VAT Prod. Posting Group" := GLAccount."VAT Bus. Posting Group";
                        end;
                end;
            end;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                "Total Price" := Round("Unit Price" * Quantity, 0.01);
            end;
        }
        field(7; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = CustomerContent;
            MinValue = 0;
            AutoFormatType = 2;

            trigger OnValidate()
            begin
                "Total Price" := Round("Unit Price" * Quantity, 0.01);
            end;
        }
        field(8; "Total Price"; Decimal)
        {
            Caption = 'Total Price';
            DataClassification = CustomerContent;
            Editable = false;
            AutoFormatType = 1;
        }
        field(9; "To Invoice"; Boolean)
        {
            Caption = 'To Invoice';
            DataClassification = CustomerContent;
            InitValue = true;
        }
        field(10; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;
        }
        field(11; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            DataClassification = CustomerContent;
            TableRelation =
                if (Type = const(Resource)) "Resource Unit of Measure".Code where("Resource No." = field("No."))
            else
            "Unit of Measure".Code;

            trigger OnValidate()
            var
                ResourceUofM: Record "Resource Unit of Measure";
            begin
                CASE Type OF
                    Type::Resource:
                        BEGIN
                            Resource.GET("No.");
                            IF "Unit of Measure Code" = '' THEN BEGIN
                                "Unit of Measure Code" := Resource."Base Unit of Measure";
                            END;
                            ResourceUofM.GET("No.", "Unit of Measure Code");
                            "Qty. per Unit of Measure" := ResourceUofM."Qty. per Unit of Measure";
                            "Total Price" := ROUND(Resource."Unit Price" * "Qty. per Unit of Measure");
                        END;
                    Type::"G/L Account":
                        BEGIN
                            "Qty. per Unit of Measure" := 1;
                        END;
                END;
                IF CurrFieldNo = FIELDNO("Unit of Measure Code") THEN BEGIN
                    VALIDATE("Unit Price");
                END;
            end;
        }
        field(12; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Product Posting Group";
        }
        field(13; "VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group';
            DataClassification = CustomerContent;
            TableRelation = "VAT Product Posting Group";
        }
        field(14; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DataClassification = CustomerContent;
        }
        field(15; Registered; Boolean)
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

    var
        Resource: Record Resource;
        GLAccount: Record "G/L Account";

    trigger OnDelete()
    begin
        TestField(Registered, false);
    end;
}

table 50021 ad_PostedSeminarCharge
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
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            TableRelation =
                if (Type = const(Resource)) Resource where(Type = const(Person), Blocked = const(false))
            else
            if (Type = const("G/L Account")) "G/L Account" where(Blocked = const(false), "Direct Posting" = const(false));
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
        }
        field(7; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = CustomerContent;
            MinValue = 0;
            AutoFormatType = 2;
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
}

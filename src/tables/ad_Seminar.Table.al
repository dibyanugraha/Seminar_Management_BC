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
            DataClassification = ToBeClassified;
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
}
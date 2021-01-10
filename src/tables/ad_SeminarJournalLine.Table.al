table 50031 ad_SeminarJournalLine
{
    Caption = 'Seminar Journal Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Journal Template Name"; Code[20])
        {
            Caption = 'Journal Template Name';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Seminar No."; Code[20])
        {
            Caption = 'Seminar No.';
            DataClassification = CustomerContent;
            TableRelation = ad_Seminar;
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Document Date" := "Posting Date";
            end;
        }
        field(5; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = CustomerContent;
        }
        field(6; "Entry Type"; Enum ad_SeminarJournalEntryType)
        {
            Caption = 'Entry Type';
            DataClassification = CustomerContent;
        }
        field(7; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(8; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(10; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;
        }
        field(11; "Charge Type"; Enum ad_SeminarJournalChargeType)
        {
            Caption = 'Charge Type';
            DataClassification = CustomerContent;
        }
        field(12; Type; Enum ad_SeminarChargeType)
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(13; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(14; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = CustomerContent;
        }
        field(15; "Total Price"; Decimal)
        {
            Caption = 'Total Price';
            DataClassification = CustomerContent;
        }
        field(16; "Participant Contact No."; Code[20])
        {
            Caption = 'Participant Contact No.';
            DataClassification = CustomerContent;
            TableRelation = Contact;
        }
        field(17; "Participant Name"; Text[100])
        {
            Caption = 'Participant Name';
            DataClassification = CustomerContent;
        }
        field(18; Chargable; Boolean)
        {
            Caption = 'Chargable';
            DataClassification = CustomerContent;
        }
        field(19; "Room Resource No."; Code[20])
        {
            Caption = 'Room Resource No.';
            DataClassification = CustomerContent;
            TableRelation = Resource where(Type = const(Room));
        }
        field(20; "Instructor Resource No."; Code[20])
        {
            Caption = 'Instructor Resource No.';
            DataClassification = CustomerContent;
            TableRelation = Resource where(Type = const(Person));
        }
        field(21; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = CustomerContent;
        }
        field(22; "Seminar Registration No."; Code[20])
        {
            Caption = 'Seminar Registration No.';
            DataClassification = CustomerContent;
        }
        field(23; "Res. Ledger Entry No."; Integer)
        {
            Caption = 'Res. Ledger Entry No.';
            DataClassification = CustomerContent;
            TableRelation = "Res. Ledger Entry";
        }
        field(30; "Source Type"; Enum ad_SeminarJournalSourceType)
        {
            Caption = 'Source Type';
            DataClassification = CustomerContent;
        }
        field(31; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            DataClassification = CustomerContent;
            TableRelation = if ("Source Type" = const(Seminar)) ad_Seminar;
        }
        field(32; "Journal Batch Name"; Code[20])
        {
            Caption = 'Journal Batch Name';
            DataClassification = CustomerContent;
        }
        field(33; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            DataClassification = CustomerContent;
            TableRelation = "Source Code";
            Editable = false;
        }
        field(34; "Reason Code"; Code[20])
        {
            Caption = 'Reason Code';
            DataClassification = CustomerContent;
            TableRelation = "Reason Code";
        }
        field(35; "Posting No. Series"; Code[20])
        {
            Caption = 'Posting No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; "Journal Template Name", "Journal Batch Name", "Line No.")
        {
            Clustered = true;
        }
    }
    procedure EmptyLine(): Boolean
    begin
        exit(("Seminar No." = '') and (Quantity = 0));
    end;
}

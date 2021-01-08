table 50001 ad_SeminarSetup
{
    Caption = 'Seminar Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        field(2; "Seminar Nos."; Code[10])
        {
            Caption = 'Seminar Nos.';
            DataClassification = CustomerContent;
        }
        field(3; "Seminar Registration Nos."; Code[10])
        {
            Caption = 'Seminar Registration Nos.';
            DataClassification = CustomerContent;
        }
        field(4; "Posted Seminar Reg. Nos."; Code[10])
        {
            Caption = 'Posted Seminar Reg. Nos.';
            DataClassification = CustomerContent;
        }
    }
    
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}

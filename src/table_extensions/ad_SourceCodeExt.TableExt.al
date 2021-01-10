tableextension 50001 ad_SourceCodeSetupExt extends "Source Code Setup"
{
    fields
    {
        field(5000; Seminar; Code[10])
        {
            Caption = 'Seminar';
            DataClassification = CustomerContent;
            TableRelation = "Source Code";
        }
    }
}

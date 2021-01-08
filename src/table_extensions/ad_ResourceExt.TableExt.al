tableextension 50000 ad_ResourceExt extends Resource
{
    fields
    {
        field(123456701; "Internal"; Boolean)
        {
            Caption = 'Internal';
            DataClassification = CustomerContent;
        }
        field(123456702; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
            DataClassification = CustomerContent;
        }
        field(123456703; "Quantity Per Day"; Decimal)
        {
            Caption = 'Quantity Per Day';
            DataClassification = CustomerContent;
        }
    }
}

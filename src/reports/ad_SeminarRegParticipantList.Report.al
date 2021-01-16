report 50001 ad_SeminarRegParticipantList
{
    Caption = 'Seminar Reg.- Participant List';
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {
        dataitem(Header; ad_SeminarRegistrationHeader)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Seminar No.";
            column(No_; "No.") { IncludeCaption = true; }
            column(Seminar_No_; "Seminar No.") { IncludeCaption = true; }
            column(Seminar_Name; "Seminar Name") { IncludeCaption = true; }
            column(Starting_Date; "Starting Date") { IncludeCaption = true; }
            column(Duration; Duration) { IncludeCaption = true; }
            column(Instructor_Name; "Instructor Name") { IncludeCaption = true; }
            column(Room_Name; "Room Name") { IncludeCaption = true; }
            dataitem(Line; ad_SeminarRegistrationLine)
            {
                DataItemTableView = sorting("Document No.", "Line No.");
                DataItemLink = "Document No." = field("No.");

                column(Bill_to_Customer_No_; "Bill-to Customer No.") { IncludeCaption = true; }
                column(Participant_Contact_No_; "Participant Contact No.") { IncludeCaption = true; }
                column(Participant_Name; "Participant Name") { IncludeCaption = true; }
            }
        }
    }
    labels
    {
        SeminarRegistrationHeader = 'SeminarRegistrationHeader';
    }
}
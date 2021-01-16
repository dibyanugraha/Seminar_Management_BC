# Dynamics 365 Business Central Seminar Management

## Background
Eons ago, Microsoft published official technical training courses for Dynamics NAV. It was titled "C/SIDE Solution Development" with study case creating a Seminar Management Module for Dynamics NAV 2013.

Nowadays, of course, that training is very outdated and is no longer applicable to be used.

This application is intended to reimplement that training courses as close as possible using Extension and AL Language, along with some improvements from latest BC.

## Structure
Each chapter will be divided into branches. Main/Master branch always provide the most complete source code.

## Additional Module
These are the list that currently (hopefully) will be added to the solution
1.  Alternative report layout using Microsoft Word. Introduced in NAV 2016, since then Microsoft word layout had grown to be main layout of most printout (a.k.a. "report" that is given to the customer) while RDLC is still widely used as analytical "report"
2.  (Basic) Approval integration to seminar registration
3.  Reverse posting/Cancel seminar registration
4.  Free pick which seminar ledger entries that will be invoiced instead of just a report along
5.  Add remaining unbilled amount to seminar ledger entries incase of participants is invoiced partially (non sense, but just for fun)
6.  And also, adds billed amount and paid amount to seminar ledger entries - these amount is normally shown in reports

## Notable notes
You may find my codes little different, there are some codes optimization and tidy up here and there, compared to the original Dynamics NAV 2013 C/AL source code. There are so many changes happened between NAV 2013 and Business Central (currently at BC 17.x a.k.a. 2020 wave 2).

These are some different that you might want to keep in mind:
1.  Reduced nested IF..THEN whenever possible (more defensive programming)
2.  The use of ISEMPTY instead of FINDFIRST if it's applicable
3.  Updated codes from latest BC 17, if there are any
4.  Avoidance of FlowField in Name field whenever possible
5.  Updated fields' length from latest BC 17 (eg. Name are lengthen to 100 now)
6.  Of course the use of Enum instead of Option
7.  Of course (again), due to new regulation, every "with" statements are out
8.  Point #7, every single pages now requires to prefix "Rec." whenever referring to table's fields or functions
9.  And more, I will post them whenever I remember

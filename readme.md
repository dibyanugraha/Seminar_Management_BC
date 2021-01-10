# Dynamics 365 Business Central Seminar Registration

## Background
Eons ago, Microsoft published official technical training course with Dynamics NAV 2013. It was title "C/SIDE Solution Development" with real world case creating a Seminar Management Module.

Nowadays, of course, that training is outdated and no longer applicable to be use.

This application is intended to reimplement that training course as close as possible using Extension and AL Language.

## Structure
Each chapter will be divided into branches. Main/Master branch always provide the most complete source code of course.

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
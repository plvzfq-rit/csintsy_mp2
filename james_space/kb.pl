/*
DO NOT TRUST    THE COMEMNTS
DO NTO THE A THE COOMENTNSDO NOT
TRUST THE COMMENT S DO 
TNOS TRUST THE COMMENTS
DP NOT TRIISTYYR THE COMMENTS
DFO NOT
TRUST THE COMEMNS FFO NOT DRST JD'AS
DDDF
DF
DO NTO TH THI THE COMMENTS
DO NOT TUST THE COMMENTS
DO NOT TRSUT THE COMEMNTS
DO  NTO TUST THE COMMENTS
DONTO RSUST THE COMMENTS
DO NOT TRUST THE COMMENTS
DO NOT TRUS THE COMMENTS
DO NOT TUST WYHT EPCJNNETMS
DO NOT TIRST THE COMMENTS
DO NOT TRUST HT  ANOF JEJPDDCD
DO NOT TRUST THE COMMENTS
DO NTOT TUST THE COMMENTS
DO NOT TRUST THE COMMENTS
DO NOT TRUST THE COMMENTS

    i. Introduction

        A knowledge base built in Prolog used in inferring familial relationships.

    ii. A Short Style Guide:

    - <relation>_declaration(A,B).
        A term used to represent declarations from an external source.
        Usually transformed into "rule" form, it may also be used as an
        argument in certain cases, e.g.:

        relative_rule(A,B) :- relative_declaration(A,C), relative_rule(C,B).

        Such is done in this case to prevent infinite recursion (and,
        therefore, stack overflow).

    - <relation>_rule(A,B).
        A term used to internally represent "declarations" (see above) and 
        conclusions derived from them. It is usually used in arguments; 
        moreover, it is also used for queries.

    The justification for having two standards is the aim of preventing 
    aforementioned problems with stack overflows.
*/

% Dynamism
:- dynamic mother_declaration/2.
:- dynamic father_declaration/2.
:- dynamic parent_declaration/2.
:- dynamic brother_declaration/2.
:- dynamic sister_declaration/2.
:- dynamic sibling_declaration/2.
:- dynamic son_declaration/2.
:- dynamic child_declaration/2.
:- dynamic daughter_declaration/2.
:- dynamic grandfather_declaration/2.
:- dynamic grandmother_declaration/2.
:- dynamic aunt_declaration/2.
:- dynamic uncle_declaration/2.

% Relatives

% If it is stated that A is the mother of B, then A and B are relatives.
relative_declaration(A,B) :- \+ A == B, (mother_declaration(A,B); mother_declaration(B,A)).

% If it is stated that A is the father of B, then A and B are relatives.
relative_declaration(A,B) :- \+ A == B, (father_declaration(A,B); father_declaration(B,A)).

% If it is stated that A is the parent of B, then A and B are relatives.
relative_declaration(A,B) :- \+ A == B, (parent_declaration(A,B); parent_declaration(B,A)).

% If it is stated that A is the son of B, then A and B are relatives.
relative_declaration(A,B) :- \+ A == B, (son_declaration(A,B); son_declaration(B,A)).

% If it is stated that A is the daughter of B, then A and B are relatives.
relative_declaration(A,B) :- \+ A == B, (daughter_declaration(A,B); daughter_declaration(B,A)).

% If it is stated that A is the child of B, then A and B are relatives.
relative_declaration(A,B) :- \+ A == B, (child_declaration(A,B); child_declaration(B,A)).

% If it is stated that A is the brother of B, then A and B are relatives.
relative_declaration(A,B) :- \+ A == B, (brother_declaration(A,B); brother_declaration(B,A)).

% If it is stated that A is the sister of B, then A and B are relatives.
relative_declaration(A,B) :- \+ A == B, (sister_declaration(A,B); sister_declaration(B,A)).

% If it is stated that A is the sibling of B, then A and B are relatives.
relative_declaration(A,B) :- \+ A == B, (sibling_declaration(A,B); sibling_declaration(B,A)).

% If it is stated that A is the grandmother of B, then A and B are relatives.
relative_declaration(A,B) :- \+ A == B, (grandmother_declaration(A,B); grandmother_declaration(B,A)).

% If it is stated that A is the grandfather of B, then A and B are relatives.
relative_declaration(A,B) :- \+ A == B, (grandfather_declaration(A,B); grandfather_declaration(B,A)).

% If it is stated that A is the uncle of B, then A and B are relatives.
relative_declaration(A,B) :- \+ A == B, (uncle_declaration(A,B); uncle_declaration(B,A)).

% If it is stated that A is the aunt of B, then A and B are relatives.
relative_declaration(A,B) :- \+ A == B, (aunt_declaration(A,B); aunt_declaration(B,A)).

relative_rule(A,B) :- \+ A == B, relative_declaration(A,B).

/*
    Special transitivity (+ symmetry) rule.
*/

% If it is stated that A is the relative of C and C is the relative of B, 
% then A is the relative of B.
relative_rule(A,B) :- \+ A == B, relative_declaration(A,C), relative_rule(C,B).

% If it is stated that A is the relative of C and C is the relative of B, 
% then B is the relative of A.
relative_rule(B,A) :- \+ A == B, relative_declaration(A,C), relative_rule(C,B).

% Femininity (Female)

% If it is stated that A is the mother of B, then A is female.
female_rule(A) :- mother_declaration(A,_).

% If it is stated that A is the grandmother of B, then A is female.
female_rule(A) :- grandmother_declaration(A,_).

% If it is stated that A is the sister of B, then A is female.
female_rule(A) :- sister_declaration(A,_).

% If it is stated that A is the daughter of B, then A is female.
female_rule(A) :- daughter_declaration(A,_).

% If it is stated that A is the aunt of B, then A is female.
female_rule(A) :- aunt_declaration(A,_).

% Masculinity (Male)

% If it is stated that A is the father of B, then A is male.
male_rule(A) :- father_declaration(A,_).

% If it is stated that A is the grandfather of B, then A is male.
male_rule(A) :- grandfather_declaration(A,_).

% If it is stated that A is the brother of B, then A is male.
male_rule(A) :- brother_declaration(A,_).

% If it is stated that A is the son of B, then A is male.
male_rule(A) :- son_declaration(A,_).

% If it is stated that A is the uncle of B, then A is male.
male_rule(A) :- uncle_declaration(A,_).

% Mother

% If it is stated that A is the mother of B, then A is the mother of B.
mother_rule(A,B) :- \+ A == B, mother_declaration(A,B).

% If A is the parent of B and A is female, then A is the mother of B.
mother_rule(A,B) :- \+ A == B, parent_rule(A,B), female_rule(A).

cannot_be_mother_rule(_,B) :- mother_rule(_,B).

cannot_be_mother_rule(A,B) :- father_rule(A,B).

cannot_be_mother_rule(A,B) :- parent_rule(B,A).

cannot_be_mother_rule(A,B) :- sibling_rule(A,B). 

cannot_be_mother_rule(A,B) :- sibling_rule(B,A).

cannot_be_mother_rule(A,B) :- child_rule(A,B).

cannot_be_mother_rule(A,B) :- grandparent_rule(A,B).

cannot_be_mother_rule(A,B) :- grandparent_rule(B,A).

cannot_be_mother_rule(A,B) :- pibling_rule(A,B).

cannot_be_mother_rule(A,B) :- pibling_rule(B,A).

cannot_be_mother_rule(A,B) :- A == B.

% not_mother_rule(A,B) :- \+ parent_rule(A,B); \+ female_rule(A); parent_rule(B,A); 
%                         sibling_rule(A,B); grandparent_rule(B,A); pibling_rule(B,A).

% Father

% If it is stated that A is the father of B, then A is the father of B.
father_rule(A,B) :- \+ A == B, father_declaration(A,B).

% If A is the parent of B and A is male, then A is the father of B.
father_rule(A,B) :- \+ A == B, parent_rule(A,B), male_rule(A).

cannot_be_father_rule(_,B) :- father_rule(_,B).

cannot_be_father_rule(A,B) :- mother_rule(A,B).

cannot_be_father_rule(A,B) :- parent_rule(B,A).

cannot_be_father_rule(A,B) :- sibling_rule(A,B). 

cannot_be_father_rule(A,B) :- sibling_rule(B,A).

cannot_be_father_rule(A,B) :- child_rule(A,B).

cannot_be_father_rule(A,B) :- grandparent_rule(A,B).

cannot_be_father_rule(A,B) :- grandparent_rule(B,A).

cannot_be_father_rule(A,B) :- pibling_rule(A,B).

cannot_be_father_rule(A,B) :- pibling_rule(B,A).

cannot_be_father_rule(A,B) :- A == B.

% not_father_rule(A,B) :- \+ parent_rule(A,B); \+ male_rule(A); parent_rule(B,A); 
%                         sibling_rule(A,B); grandparent_rule(B,A); pibling_rule(B,A).

% Parent

% If it is stated that A is the parent of B, then A is the parent of B.
parent_rule(A,B) :- \+ A == B, parent_declaration(A,B).

% If A is the mother of B, then A is the parent of B.
parent_rule(A,B) :- \+ A == B, mother_declaration(A,B).

% If A is the father of B, then A is a parent of B.
parent_rule(A,B) :- \+ A == B, father_declaration(A,B).

% If A is a child of B, then B is a parent of A.
parent_rule(B,A) :- \+ A == B, child_declaration(A,B).

% If A is the daughter of B, then B is the parent of A.
parent_rule(B,A) :- \+ A == B, daughter_declaration(A,B).

% If A is the son of B, then B is the parent of A.
parent_rule(B,A) :- \+ A == B, son_declaration(A,B).

cannot_be_parent_rule(A,B) :- sibling_rule(A,B). 

cannot_be_parent_rule(A,B) :- sibling_rule(B,A).

cannot_be_parent_rule(A,B) :- child_rule(A,B).

cannot_be_parent_rule(A,B) :- parent_rule(B,A).

cannot_be_parent_rule(A,B) :- grandparent_rule(B,A).

cannot_be_parent_rule(A,B) :- grandparent_rule(A,B).

cannot_be_parent_rule(A,B) :- pibling_rule(A,B).

cannot_be_parent_rule(A,B) :- pibling_rule(B,A).

cannot_be_parent_rule(A,B) :- A == B.

% not_parent_rule(A,B) :- \+ parent_rule(A,B); parent_rule(B,A);
%                         \+ child_rule(B,A); child_rule(A,B);
%                         sibling_rule(A,B); pibling_rule(A,B);
%                         pibling_rule(B,A); grandparent_rule(A,B);
%                         grandparent_rule(B,A).

% Daughter

% If it is stated that A is the daughter of B, then A is the daughter of B.
daughter_rule(A,B) :- \+ A == B, daughter_declaration(A,B).

% If A is a child of B and A is female, then A is the duaghter of B.
daughter_rule(A,B) :- \+ A == B, child_rule(A,B), female_rule(A).

cannot_be_daughter_rule(A,B) :- parent_rule(A,B).

cannot_be_daughter_rule(A,B) :- sibling_rule(A,B). 

cannot_be_daughter_rule(A,B) :- sibling_rule(B,A).

cannot_be_daughter_rule(A,B) :- son_rule(A,B).

cannot_be_daughter_rule(A,B) :- child_rule(B,A).

cannot_be_daughter_rule(A,B) :- grandparent_rule(B,A).

cannot_be_daughter_rule(A,B) :- grandparent_rule(A,B).

cannot_be_daughter_rule(A,B) :- pibling_rule(A,B).

cannot_be_daughter_rule(A,B) :- pibling_rule(B,A).

cannot_be_daughter_rule(A,B) :- A == B.

% not_daughter_rule(A,B) :- \+ child_rule(A,B); \+ female_rule(A); child_rule(B,A); 
%                         sibling_rule(A,B); grandparent_rule(B,A); pibling_rule(B,A).

% Son

% If it is stated that A is the son of B, then A is the son of B.
son_rule(A,B) :- \+ A == B, son_declaration(A,B).

% If A is a child of B and A is male, than A is the son of B.
son_rule(A,B) :- \+ A == B, child_rule(A,B), male_rule(A).

cannot_be_son_rule(A,B) :- parent_rule(A,B).

cannot_be_son_rule(A,B) :- sibling_rule(A,B). 

cannot_be_son_rule(A,B) :- sibling_rule(B,A).

cannot_be_son_rule(A,B) :- daughter_rule(A,B).

cannot_be_son_rule(A,B) :- child_rule(B,A).

cannot_be_son_rule(A,B) :- grandparent_rule(B,A).

cannot_be_son_rule(A,B) :- grandparent_rule(A,B).

cannot_be_son_rule(A,B) :- pibling_rule(A,B).

cannot_be_son_rule(A,B) :- pibling_rule(B,A).

cannot_be_son_rule(A,B) :- A == B.
% not_son_rule(A,B) :- \+ child_rule(A,B); \+ male_rule(A); child_rule(B,A); 
%                         sibling_rule(A,B); grandparent_rule(B,A); pibling_rule(B,A).

% Child

% If it is stated that A is a child of B, then A is a child of B.
child_rule(A,B) :- \+ A == B, child_declaration(A,B).

% If A is the mother of B, then B is the child of A.
child_rule(B,A) :- \+ A == B, mother_declaration(A,B).

% If A is the father of B, then B is the child of A.
child_rule(B,A) :- \+ A == B, father_declaration(A,B).

% If A is a parent of B, then B is a child of A.
child_rule(B,A) :- \+ A == B, parent_declaration(A,B).

% If A is the daughter of B, then A is the child of B.
child_rule(A,B) :- \+ A == B, daughter_declaration(A,B).

% If A is the son of B, then A is the child of B.
child_rule(A,B) :- \+ A == B, son_declaration(A,B).

cannot_be_child_rule(A,B) :- sibling_rule(A,B). 

cannot_be_child_rule(A,B) :- sibling_rule(B,A).

cannot_be_child_rule(A,B) :- child_rule(B,A).

cannot_be_child_rule(A,B) :- parent_rule(A,B).

cannot_be_child_rule(A,B) :- grandparent_rule(B,A).

cannot_be_child_rule(A,B) :- grandparent_rule(A,B).

cannot_be_child_rule(A,B) :- pibling_rule(A,B).

cannot_be_child_rule(A,B) :- pibling_rule(B,A).

cannot_be_child_rule(A,B) :- A == B.

% not_child_rule(A,B) :- \+ parent_rule(B,A); parent_rule(A,B);
%                         \+ child_rule(A,B); child_rule(B,A);
%                         sibling_rule(A,B); pibling_rule(A,B);
%                         pibling_rule(B,A); grandparent_rule(A,B);
%                         grandparent_rule(B,A).

% Brother

% If it is stated that A is the brother of B, then A is the brother of B.
brother_rule(A,B) :- \+ A == B, brother_declaration(A,B).

% If A is the sibling of B and A is male, then A is the brother of B.
brother_rule(A,B) :- \+ A == B, sibling_rule(A,B), male_rule(A).

cannot_be_brother_rule(A,B) :- parent_rule(A,B).

cannot_be_brother_rule(A,B) :- parent_rule(B,A). 

cannot_be_brother_rule(A,B) :- child_rule(A,B).

cannot_be_brother_rule(A,B) :- child_rule(B,A).

cannot_be_brother_rule(A,B) :- grandparent_rule(B,A).

cannot_be_brother_rule(A,B) :- grandparent_rule(A,B).

cannot_be_brother_rule(A,B) :- pibling_rule(A,B).

cannot_be_brother_rule(A,B) :- pibling_rule(B,A).

cannot_be_brother_rule(A,B) :- sister_rule(A,B).

cannot_be_brother_rule(A,B) :- A == B.

% not_brother_rule(A,B) :- \+ sibling_rule(A,B); \+ male_rule(A);
%                          parent_rule(A,B); parent_rule(B,A);
%                          child_rule(A,B); child_rule(B,A);
%                          grandparent_rule(A,B); grandparent_rule(B,A);
%                          pibling_rule(A,B); pibling_rule(B,A).
% Sister

% If it is stated that A is the sister of B, then A is the sister of B.
sister_rule(A,B) :- \+ A == B, brother_declaration(A,B).

% If A is the sibling of B and A is female, then A is the sister of B.
sister_rule(A,B) :- \+ A == B, sibling_rule(A,B), female_rule(A).

cannot_be_sister_rule(A,B) :- parent_rule(A,B).

cannot_be_sister_rule(A,B) :- parent_rule(B,A). 

cannot_be_sister_rule(A,B) :- child_rule(A,B).

cannot_be_sister_rule(A,B) :- child_rule(B,A).

cannot_be_sister_rule(A,B) :- grandparent_rule(B,A).

cannot_be_sister_rule(A,B) :- grandparent_rule(A,B).

cannot_be_sister_rule(A,B) :- pibling_rule(A,B).

cannot_be_sister_rule(A,B) :- pibling_rule(B,A).

cannot_be_sister_rule(A,B) :- brother_rule(A,B).

cannot_be_sister_rule(A,B) :- A == B.

% not_sister_rule(A,B) :- \+ sibling_rule(A,B); \+ female_rule(A);
%                          parent_rule(A,B); parent_rule(B,A);
%                          child_rule(A,B); child_rule(B,A);
%                          grandparent_rule(A,B); grandparent_rule(B,A);
%                          pibling_rule(A,B); pibling_rule(B,A).

% Sibling

% If it is stated that A a sibling of B, then A is a sibling of B.
sibling_rule(A,B) :- \+ A == B, sibling_declaration(A,B).

% If it is stated that A a sibling of B, then B is a sibling of A.
sibling_rule(B,A) :- \+ A == B, sibling_declaration(A,B).

% If C is the parent of A and C is the parent of B, then A is a sibling of B.
sibling_rule(A,B) :- \+ A == B, parent_rule(C,A), parent_rule(C,B).

% If C is the parent of A and C is the parent of B, then B is a sibling of A.
sibling_rule(B,A) :- \+ A == B, parent_rule(C,A), parent_rule(C,B).

% If A is the brother of B, then A is a sibling of B.
sibling_rule(A,B) :- \+ A == B, brother_declaration(A,B).

% If A is the brother of B, then B is a sibling of A.
sibling_rule(B,A) :- \+ A == B, brother_declaration(A,B).

% If A is the sister of B, then A is a sibling of B.
sibling_rule(A,B) :- \+ A == B, sister_declaration(A,B).

% If A is the sister of B, then B is a sibling of A.
sibling_rule(B,A) :- \+ A == B, sister_declaration(A,B).

cannot_be_sibling_rule(A,B) :- child_rule(A,B). 

cannot_be_sibling_rule(A,B) :- parent_rule(B,A).

cannot_be_sibling_rule(A,B) :- child_rule(B,A).

cannot_be_sibling_rule(A,B) :- parent_rule(A,B).

cannot_be_sibling_rule(A,B) :- grandparent_rule(B,A).

cannot_be_sibling_rule(A,B) :- grandparent_rule(A,B).

cannot_be_sibling_rule(A,B) :- pibling_rule(A,B).

cannot_be_sibling_rule(A,B) :- pibling_rule(B,A).

cannot_be_sibling_rule(A,B) :- A == B.

% Grandfather

% If A is stated that A is the grandfather of B, then A is the grandfather of B.
grandfather_rule(A,B) :- \+ A == B, grandfather_declaration(A,B).

% If A is the grandparent of B and A is male, then A is the grandfather of B.
grandfather_rule(A,B) :- \+ A == B, grandparent_rule(A,B), male_rule(A).

cannot_be_grandfather_rule(A,B) :- parent_rule(A,B).

cannot_be_grandfather_rule(A,B) :- parent_rule(B,A).

cannot_be_grandfather_rule(A,B) :- sibling_rule(A,B). 

cannot_be_grandfather_rule(A,B) :- sibling_rule(B,A).

cannot_be_grandfather_rule(A,B) :- child_rule(A,B).

cannot_be_grandfather_rule(A,B) :- child_rule(B,A).

cannot_be_grandfather_rule(A,B) :- grandparent_rule(B,A).

cannot_be_grandfather_rule(A,B) :- grandmother_rule(A,B).

cannot_be_grandfather_rule(A,B) :- pibling_rule(A,B).

cannot_be_grandfather_rule(A,B) :- pibling_rule(B,A).

cannot_be_grandfather_rule(A,B) :- A == B.

% Grandmother

% If A is stated that A is the grandmother of B, then A is the grandmother of B.
grandmother_rule(A,B) :- \+ A == B, grandmother_declaration(A,B).

% If A is the grandparent of B and A is frmale, then A is the grandmother of B.
grandmother_rule(A,B) :- \+ A == B, grandparent_rule(A,B), female_rule(A).

cannot_be_grandmother_rule(A,B) :- parent_rule(A,B).

cannot_be_grandmother_rule(A,B) :- parent_rule(B,A).

cannot_be_grandmother_rule(A,B) :- sibling_rule(A,B). 

cannot_be_grandmother_rule(A,B) :- sibling_rule(B,A).

cannot_be_grandmother_rule(A,B) :- child_rule(A,B).

cannot_be_grandmother_rule(A,B) :- child_rule(B,A).

cannot_be_grandmother_rule(A,B) :- grandparent_rule(B,A).

cannot_be_grandmother_rule(A,B) :- grandfather_rule(A,B).

cannot_be_grandmother_rule(A,B) :- pibling_rule(A,B).

cannot_be_grandmother_rule(A,B) :- pibling_rule(B,A).

cannot_be_grandmother_rule(A,B) :- A == B.

% Grandparent

% If A is a grandfather of B, then A is a grandparent of B.
grandparent_rule(A,B) :- \+ A == B, grandfather_declaration(A,B).

% If A is a grandmother of B, then A is a grandparent of B.
grandparent_rule(A,B) :- \+ A == B, grandmother_declaration(A,B).

% If A is a parent of C and C is a parent of B, then A is a grandparent of B.
grandparent_rule(A,B) :- \+ A == B, parent_rule(A,C), parent_rule(C,B).

% If B is a child of C and C is a child of A, then A is a grandparent of B.
grandparent_rule(A,B) :- \+ A == B, child_rule(B, C), child_rule(C, A).

% If A is a parent of C and B is a child of C, then A is a grandparent of B.
grandparent_rule(A,B) :- \+ A == B, parent_rule(A,C), child_rule(B,C).

% Uncle

% If it is stated that A is an uncle of B, then A is an uncle of B.
uncle_rule(A,B) :- \+ A == B, uncle_declaration(A,B).

% If A is a publing of B and A is male, then A is an uncle of B.
uncle_rule(A,B) :- \+ A == B, pibling_rule(A,B), male_rule(A).

cannot_be_uncle_rule(A,B) :- parent_rule(A,B).

cannot_be_uncle_rule(A,B) :- parent_rule(B,A).

cannot_be_uncle_rule(A,B) :- sibling_rule(A,B). 

cannot_be_uncle_rule(A,B) :- sibling_rule(B,A).

cannot_be_uncle_rule(A,B) :- child_rule(A,B).

cannot_be_uncle_rule(A,B) :- child_rule(B,A).

cannot_be_uncle_rule(A,B) :- grandparent_rule(B,A).

cannot_be_uncle_rule(A,B) :- grandparent_rule(A,B).

cannot_be_uncle_rule(A,B) :- aunt_rule(A,B).

cannot_be_uncle_rule(A,B) :- pibling_rule(B,A).

cannot_be_uncle_rule(A,B) :- A == B.
% Aunt

% If it is stated that A is an aunt of B, then A is an aunt of B.
aunt_rule(A,B) :- \+ A == B, aunt_declaration(A,B).

% If A is a publing of B and A is female, then A is an aunt of B.
aunt_rule(A,B) :- \+ A == B, pibling_rule(A,B), male_rule(A).

cannot_be_aunt_rule(A,B) :- parent_rule(A,B).

cannot_be_aunt_rule(A,B) :- parent_rule(B,A).

cannot_be_aunt_rule(A,B) :- sibling_rule(A,B). 

cannot_be_aunt_rule(A,B) :- sibling_rule(B,A).

cannot_be_aunt_rule(A,B) :- child_rule(A,B).

cannot_be_aunt_rule(A,B) :- child_rule(B,A).

cannot_be_aunt_rule(A,B) :- grandparent_rule(B,A).

cannot_be_aunt_rule(A,B) :- grandparent_rule(A,B).

cannot_be_aunt_rule(A,B) :- uncle_rule(A,B).

cannot_be_aunt_rule(A,B) :- pibling_rule(B,A).

cannot_be_aunt_rule(A,B) :- A == B.

% Pibling

% If A is an uncle of B, then A is a pibling of B.
pibling_rule(A,B) :- \+ A == B, uncle_declaration(A,B).

% If A is an aunt of B, then A is a pibling of B.
pibling_rule(A,B) :- \+ A == B, aunt_declaration(A,B).

% If A is a sibling of C and C is a parent of B, then A is a pibling of B.
pibling_rule(A,B) :- \+ A == B, sibling_rule(A,C), parent_rule(C,B).

% % just so the squigglies dont annoy me
% mother_declaration(albert, bertha).
% father_declaration(herbert, polloac).
% grandmother_declaration(elise, pollo).
% grandfather_declaration(herbert, pontoon).
% brother_declaration(illinois, chicago).
% sister_declaration(pon, sip).
% sibling_declaration(pata, pon).
% uncle_declaration(pil, bury).
% aunt_declaration(pass, pot).
% grandparent_declaration(print, port).
% parent_declaration(silt, solve).
% son_declaration(int, char).
% child_declaration(pe, po).
% son_declaration(pi, po).
% daughter_declaration(up, down).
% relative_declaration(re, ro).
% relative_rule(i, ii).
% pibling_declaration(x,y).
% niece_rule(x,y).
% nephew_rule(x,y).
% nibling_rule(x,y).
% pibling_rule(x,y).
% female(x).
% male(x).

/*
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

% ERRATUM: "\+ A == B" means that A must NOT equal B. This was added after the
% fact in every rule and, due to the scale of work, is not added to the
% representation above.


% Dynamism
:- dynamic mother_declaration/2.
:- dynamic father_declaration/2.
:- dynamic parent_declaration/2.
:- dynamic brother_declaration/2.
:- dynamic sister_declaration/2.
:- dynamic sibling_declaration/2.
:- dynamic son_declaration/2.
:- dynamic daughter_declaration/2.
:- dynamic grandfather_declaration/2.
:- dynamic grandmother_declaration/2.
:- dynamic aunt_declaration/2.
:- dynamic uncle_declaration/2.

% Relatives

% If it is stated that A is the mother of B, then A and B are relatives.
relative_rule(A,B) :- mother_declaration(A,B), \+ A == B.

% If it is stated that A is the father of B, then A and B are relatives.
relative_rule(A,B) :- father_declaration(A,B), \+ A == B.

% If it is stated that A is the parent of B, then A and B are relatives.
relative_rule(A,B) :- parent_declaration(A,B), \+ A == B.

% If it is stated that A is the son of B, then A and B are relatives.
relative_rule(A,B) :- son_declaration(A,B), \+ A == B.

% If it is stated that A is the daughter of B, then A and B are relatives.
relative_rule(A,B) :- daughter_declaration(A,B), \+ A == B.

% If it is stated that A is the child of B, then A and B are relatives.
relative_rule(A,B) :- child_declaration(A,B), \+ A == B.

% If it is stated that A is the brother of B, then A and B are relatives.
relative_rule(A,B) :- brother_declaration(A,B), \+ A == B.

% If it is stated that A is the sister of B, then A and B are relatives.
relative_rule(A,B) :- sister_declaration(A,B), \+ A == B.

% If it is stated that A is the sibling of B, then A and B are relatives.
relative_rule(A,B) :- sibling_declaration(A,B), \+ A == B.

% If it is stated that A is the grandmother of B, then A and B are relatives.
relative_rule(A,B) :- grandmother_declaration(A,B), \+ A == B.

% If it is stated that A is the grandfather of B, then A and B are relatives.
relative_rule(A,B) :- grandfather_declaration(A,B), \+ A == B.

% If it is stated that A is the grandparent of B, then A and B are relatives.
relative_rule(A,B) :- grandparent_declaration(A,B), \+ A == B.

% If it is stated that A is the uncle of B, then A and B are relatives.
relative_rule(A,B) :- uncle_declaration(A,B), \+ A == B.

% If it is stated that A is the aunt of B, then A and B are relatives.
relative_rule(A,B) :- aunt_declaration(A,B), \+ A == B.

% If A is the pibling of B, then A and B are relatives.
relative_rule(A,B) :- pibling_rule(A,B), \+ A == B.

% % If A is the niece of B, then A and B are relatives.
% relative_rule(A,B) :- niece_rule(A,B).

% % If A is the nephew of B, then A and B are relatives.
% relative_rule(A,B) :- nephew_rule(A,B).

% % If A is the nibling of B, then A and B are relatives.
% relative_rule(A,B) :- nibling_rule(A,B).

/*
    Special symmetry rule.
*/

% If it is stated that A is the relative of B, then A is the relative of B.
relative_rule(A,B) :- relative_declaration(A,B), \+ A == B.

% If it is stated that A is the relative of B, then B is the relative of A.
relative_rule(B,A) :- relative_declaration(A,B), \+ A == B.

/*
    Special transitivity (+ symmetry) rule.
*/

% If it is stated that A is the relative of C and C is the relative of B, 
% then A is the relative of B.
relative_rule(A,B) :- relative_declaration(A,C), relative_rule(C,B), \+ A == B.

% If it is stated that A is the relative of C and C is the relative of B, 
% then B is the relative of A.
relative_rule(B,A) :- relative_declaration(A,C), relative_rule(C,B), \+ A == B.

% Femininity (Female)

% If it is stated that A is the mother of B, then A is female.
female_rule(A) :- mother_declaration(A,B), \+ A == B.

% If it is stated that A is the grandmother of B, then A is female.
female_rule(A) :- grandmother_declaration(A,B), \+ A == B.

% If it is stated that A is the sister of B, then A is female.
female_rule(A) :- sister_declaration(A,B), \+ A == B.

% If it is stated that A is the daughter of B, then A is female.
female_rule(A) :- daughter_declaration(A,B), \+ A == B.

% If it is stated that A is the aunt of B, then A is female.
female_rule(A) :- aunt_declaration(A,B), \+ A == B.

% % If A is the niece of B, then A is female.
% female_rule(A) :- niece_rule(A,B).

% Masculinity (Male)

% If it is stated that A is the father of B, then A is male.
male_rule(A) :- father_declaration(A,B), \+ A == B.

% If it is stated that A is the grandfather of B, then A is male.
male_rule(A) :- grandfather_declaration(A,B), \+ A == B.

% If it is stated that A is the brother of B, then A is male.
male_rule(A) :- brother_declaration(A,B), \+ A == B.

% If it is stated that A is the son of B, then A is male.
male_rule(A) :- son_declaration(A,B), \+ A == B.

% If it is stated that A is the uncle of B, then A is male.
male_rule(A) :- uncle_declaration(A,B), \+ A == B.

% % If A is the nephew of B, then A is male.
% male_rule(A) :- nephew_rule(A,B).

% Mother

% If it is stated that A is the mother of B, then A is the mother of B.
mother_rule(A,B) :- \+ A == B, mother_declaration(A,B).

% If A is the parent of B and A is female, then A is the mother of B.
mother_rule(A,B) :- \+ A == B, parent_rule(A,B), female_rule(A).

% Father

% If it is stated that A is the father of B, then A is the father of B.
father_rule(A,B) :- \+ A == B, father_declaration(A,B).

% If A is the parent of B and A is male, then A is the father of B.
father_rule(A,B) :- \+ A == B, parent_rule(A,B), male_rule(A).

% Parent

% If it is stated that A is the parent of B, then A is the parent of B.
parent_rule(A,B) :- \+ A == B, parent_declaration(A,B).

% If A is the mother of B, then A is the parent of B.
parent_rule(A,B) :- \+ A == B, mother_rule(A,B).

% If A is the father of B, then A is a parent of B.
parent_rule(A,B) :- \+ A == B, father_rule(A,B).

% If A is a child of B, then B is a parent of A.
parent_rule(B,A) :- \+ A == B, child_rule(A,B).

% If A is the daughter of B, then B is the parent of A.
parent_rule(B,A) :- \+ A == B, daughter_rule(A,B).

% If A is the son of B, then B is the parent of A.
parent_rule(B,A) :- \+ A == B, son_rule(A,B).

% Daughter

% If it is stated that A is the daughter of B, then A is the daughter of B.
daughter_rule(A,B) :- \+ A == B, daughter_declaration(A,B).

% If A is a child of B and A is female, then A is the duaghter of B.
daughter_rule(A,B) :- \+ A == B, child_rule(A,B), female_rule(A).

% Son

% If it is stated that A is the son of B, then A is the son of B.
son_rule(A,B) :- \+ A == B, son_declaration(A,B).

% If A is a child of B and A is male, than A is the son of B.
son_rule(A,B) :- \+ A == B, child_rule(A,B), male_rule(A).

% Child

% If it is stated that A is a child of B, then A is a child of B.
child_rule(A,B) :- \+ A == B, child_declaration(A,B).

% If A is the mother of B, then B is the child of A.
child_rule(B,A) :- \+ A == B, mother_rule(A,B).

% If A is the father of B, then B is the child of A.
child_rule(B,A) :- \+ A == B, father_rule(A,B).

% If A is a parent of B, then B is a child of A.
child_rule(B,A) :- \+ A == B, parent_rule(A,B).

% If A is the daughter of B, then A is the child of B.
child_rule(A,B) :- \+ A == B, daughter_rule(A,B).

% If A is the son of B, then A is the child of B.
child_rule(A,B) :- \+ A == B, son_rule(A,B).

% Brother

% If it is stated that A is the brother of B, then A is the brother of B.
brother_rule(A,B) :- \+ A == B, brother_declaration(A,B).

% If A is the sibling of B and A is male, then A is the brother of B.
brother_rule(A,B) :- \+ A == B, sibling_rule(A,B), male_rule(A).

% Sister

% If it is stated that A is the sister of B, then A is the sister of B.
sister_rule(A,B) :- \+ A == B, brother_declaration(A,B).

% If A is the sibling of B and A is female, then A is the sister of B.
sister_rule(A,B) :- \+ A == B, sibling_rule(A,B), female_rule(A).

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
sibling_rule(A,B) :- \+ A == B, brother_rule(A,B).

% If A is the brother of B, then B is a sibling of A.
sibling_rule(B,A) :- \+ A == B, brother_rule(A,B).

% If A is the sister of B, then A is a sibling of B.
sibling_rule(A,B) :- \+ A == B, sister_rule(A,B).

% If A is the sister of B, then B is a sibling of A.
sibling_rule(B,A) :- \+ A == B, sister_rule(A,B).

% Grandfather

% If A is stated that A is the grandfather of B, then A is the grandfather of B.
grandfather_rule(A,B) :- \+ A == B, grandfather_declaration(A,B).

% If A is the grandparent of B and A is male, then A is the grandfather of B.
grandfather_rule(A,B) :- \+ A == B, grandparent_rule(A,B), male_rule(A).


% Grandmother

% If A is stated that A is the grandmother of B, then A is the grandmother of B.
grandmother_rule(A,B) :- \+ A == B, grandmother_declaration(A,B).

% If A is the grandparent of B and A is frmale, then A is the grandmother of B.
grandmother_rule(A,B) :- \+ A == B, grandparent_rule(A,B), female_rule(A).

% Grandparent

% If A is a grandfather of B, then A is a grandparent of B.
grandparent_rule(A,B) :- \+ A == B, grandfather_rule(A,B).

% If A is a grandmother of B, then A is a grandparent of B.
grandparent_rule(A,B) :- \+ A == B, grandmother_rule(A,B).

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

% Aunt

% If it is stated that A is an aunt of B, then A is an aunt of B.
aunt_rule(A,B) :- \+ A == B, aunt_declaration(A,B).

% If A is a publing of B and A is female, then A is an aunt of B.
aunt_rule(A,B) :- \+ A == B, pibling_rule(A,B), male_rule(A).

% Pibling

% If A is an uncle of B, then A is a pibling of B.
pibling_rule(A,B) :- \+ A == B, uncle_rule(A,B).

% If A is an aunt of B, then A is a pibling of B.
pibling_rule(A,B) :- \+ A == B, aunt_rule(A,B).

% If A is a sibling of C and C is a parent of B, then A is a pibling of B.
pibling_rule(A,B) :- \+ A == B, sibling_rule(A,C), parent_rule(C,B).

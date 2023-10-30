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

% Mother

% If it is stated that A is the mother of B, then A is the mother of B.
mother_rule(A,B) :- \+ A == B, mother_declaration(A,B).

% Father

% If it is stated that A is the father of B, then A is the father of B.
father_rule(A,B) :- \+ A == B, father_declaration(A,B).

% Parent

% If it is stated that A is the parent of B, then A is the parent of B.
parent_rule(A,B) :- \+ A == B, parent_declaration(A,B).

% Daughter

% If it is stated that A is the daughter of B, then A is the daughter of B.
daughter_rule(A,B) :- \+ A == B, daughter_declaration(A,B).

% Son

% If it is stated that A is the son of B, then A is the son of B.
son_rule(A,B) :- \+ A == B, son_declaration(A,B).

% Child

% If it is stated that A is a child of B, then A is a child of B.
child_rule(A,B) :- \+ A == B, child_declaration(A,B).

% Brother

% If it is stated that A is the brother of B, then A is the brother of B.
brother_rule(A,B) :- \+ A == B, brother_declaration(A,B).

% Sister

% If it is stated that A is the sister of B, then A is the sister of B.
sister_rule(A,B) :- \+ A == B, brother_declaration(A,B).

% Sibling

% If it is stated that A a sibling of B, then A is a sibling of B.
sibling_rule(A,B) :- \+ A == B, sibling_declaration(A,B).

% If it is stated that A a sibling of B, then B is a sibling of A.
sibling_rule(B,A) :- \+ A == B, sibling_declaration(A,B).

% Grandfather

% If A is stated that A is the grandfather of B, then A is the grandfather of B.
grandfather_rule(A,B) :- \+ A == B, grandfather_declaration(A,B).

% Grandmother

% If A is stated that A is the grandmother of B, then A is the grandmother of B.
grandmother_rule(A,B) :- \+ A == B, grandmother_declaration(A,B).

% Uncle

% If it is stated that A is an uncle of B, then A is an uncle of B.
uncle_rule(A,B) :- \+ A == B, uncle_declaration(A,B).

% Aunt

% If it is stated that A is an aunt of B, then A is an aunt of B.
aunt_rule(A,B) :- \+ A == B, aunt_declaration(A,B).


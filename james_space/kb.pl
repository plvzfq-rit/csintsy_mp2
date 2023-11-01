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

% If A is not equal to B and it is stated that A is the mother of B, then A is the mother of B.
mother_rule(A,B) :- \+ A == B, mother_declaration(A,B).

cannot_be_mother_rule(A,_) :- \+ female_rule(A); male_rule(A).

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

% Father

% If it is stated that A is the father of B, then A is the father of B.
father_rule(A,B) :- \+ A == B, father_declaration(A,B).

cannot_be_father_rule(A,_) :- female_rule(A); \+ male_rule(A).

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

% Parent

% If it is stated that A is the parent of B, then A is the parent of B.
parent_rule(A,B) :- \+ A == B, parent_declaration(A,B).

cannot_be_parent_rule(A,B) :- sibling_rule(A,B). 

cannot_be_parent_rule(A,B) :- sibling_rule(B,A).

cannot_be_parent_rule(A,B) :- child_rule(A,B).

cannot_be_parent_rule(A,B) :- parent_rule(B,A).

cannot_be_parent_rule(A,B) :- grandparent_rule(B,A).

cannot_be_parent_rule(A,B) :- grandparent_rule(A,B).

cannot_be_parent_rule(A,B) :- pibling_rule(A,B).

cannot_be_parent_rule(A,B) :- pibling_rule(B,A).

cannot_be_parent_rule(A,B) :- A == B.

% Daughter

% If it is stated that A is the daughter of B, then A is the daughter of B.
daughter_rule(A,B) :- \+ A == B, daughter_declaration(A,B).

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

% Son

% If it is stated that A is the son of B, then A is the son of B.
son_rule(A,B) :- \+ A == B, son_declaration(A,B).

cannot_be_son_rule(A,_) :- female_rule(A); \+ male_rule(A).

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

% Child

% If it is stated that A is a child of B, then A is a child of B.
child_rule(A,B) :- \+ A == B, child_declaration(A,B).

cannot_be_child_rule(A,B) :- sibling_rule(A,B). 

cannot_be_child_rule(A,B) :- sibling_rule(B,A).

cannot_be_child_rule(A,B) :- child_rule(B,A).

cannot_be_child_rule(A,B) :- parent_rule(A,B).

cannot_be_child_rule(A,B) :- grandparent_rule(B,A).

cannot_be_child_rule(A,B) :- grandparent_rule(A,B).

cannot_be_child_rule(A,B) :- pibling_rule(A,B).

cannot_be_child_rule(A,B) :- pibling_rule(B,A).

cannot_be_child_rule(A,B) :- A == B.


% Brother

% If it is stated that A is the brother of B, then A is the brother of B.
brother_rule(A,B) :- \+ A == B, brother_declaration(A,B).

cannot_be_brother_rule(A,_) :- female_rule(A); \+ male_rule(A).

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

% Sister

% If it is stated that A is the sister of B, then A is the sister of B.
sister_rule(A,B) :- \+ A == B, brother_declaration(A,B).

cannot_be_sister_rule(A,_) :- \+ female_rule(A); male_rule(A).

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

% Sibling

% If it is stated that A a sibling of B, then A is a sibling of B.
sibling_rule(A,B) :- \+ A == B, sibling_declaration(A,B).

% If it is stated that A a sibling of B, then B is a sibling of A.
sibling_rule(B,A) :- \+ A == B, sibling_declaration(A,B).

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

cannot_be_grandfather_rule(A,_) :- female_rule(A); \+ male_rule(A).

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

cannot_be_grandmother_rule(A,_) :- \+ female_rule(A); male_rule(A).

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

% Uncle

% If it is stated that A is an uncle of B, then A is an uncle of B.
uncle_rule(A,B) :- \+ A == B, uncle_declaration(A,B).

cannot_be_uncle_rule(A,_) :- female_rule(A); \+ male_rule(A).

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

cannot_be_aunt_rule(A,_) :- \+ female_rule(A); male_rule(A).

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


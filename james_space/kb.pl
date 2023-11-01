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

% If A is not a female, or A is a male, A cannot be the mother.
cannot_be_mother_rule(A,_) :- \+ female_rule(A); male_rule(A).

% If there is any person who is the mother of B, then A cannot be the mother of B.
cannot_be_mother_rule(_,B) :- mother_rule(_,B).

% If A is the father of B, then A cannot be the mother of B.
cannot_be_mother_rule(A,B) :- father_rule(A,B).

% If A is a parent of B, then A cannot be the mother of B.
cannot_be_mother_rule(A,B) :- parent_rule(B,A).

% If A is a sibling of B, then A cannot be the mother of B.
cannot_be_mother_rule(A,B) :- sibling_rule(A,B). 

% If B is a sibling of A, then A cannot be the mother of B.
cannot_be_mother_rule(A,B) :- sibling_rule(B,A).

% If A is a child of B, then A cannot be the mother of B.
cannot_be_mother_rule(A,B) :- child_rule(A,B).

% If A is a grandparent of B, then A cannot be the mother of B.
cannot_be_mother_rule(A,B) :- grandparent_rule(A,B).

% If B is a grandparent of A, then A cannot be the mother of B.
cannot_be_mother_rule(A,B) :- grandparent_rule(B,A).

% If A is a pibling of B, then A cannot be the mother of B.
cannot_be_mother_rule(A,B) :- pibling_rule(A,B).

% If B is a pibling of A, then A cannot be the mother of B.
cannot_be_mother_rule(A,B) :- pibling_rule(B,A).

% If A is equal to B, then A cannot be the mother of B.
cannot_be_mother_rule(A,B) :- A == B.


% Father

% If A is not equal to B and it is stated that A is the father of B, then A is the father of B.
father_rule(A,B) :- \+ A == B, father_declaration(A,B).

% If A is a female, or A is not a male, A cannot be the father of B.
cannot_be_father_rule(A,_) :- female_rule(A); \+ male_rule(A).

% If there is any person who is the father of B, then A cannot be the father of B.
cannot_be_father_rule(_,B) :- father_rule(_,B).

% If A is the mother of B, then A cannot be the father of B.
cannot_be_father_rule(A,B) :- mother_rule(A,B).

% If A is a parent of B, then A cannot be the father of B.
cannot_be_father_rule(A,B) :- parent_rule(B,A).

% If A is a sibling of B, then A cannot be the father of B.
cannot_be_father_rule(A,B) :- sibling_rule(A,B). 

% If B is a sibling of A, then A cannot be the father of B.
cannot_be_father_rule(A,B) :- sibling_rule(B,A).

% If A is a child of B, then A cannot be the father.
cannot_be_father_rule(A,B) :- child_rule(A,B).

% If A is a grandparent of B, then A cannot be the father of B.
cannot_be_father_rule(A,B) :- grandparent_rule(A,B).

% If B is a grandparent of A, then A cannot be the father of B.
cannot_be_father_rule(A,B) :- grandparent_rule(B,A).

% If A is a pibling of B, then A cannot be the father of B.
cannot_be_father_rule(A,B) :- pibling_rule(A,B).

% If B is a pibling of A, then A cannot be the father of B.
cannot_be_father_rule(A,B) :- pibling_rule(B,A).

% If A is equal to B, then A cannot be the father of B.
cannot_be_father_rule(A,B) :- A == B.


% Parent

% If A is not equal to B and it is stated that A is the parent of B, then A is the parent of B.
parent_rule(A,B) :- \+ A == B, parent_declaration(A,B).

% If A is a sibling of B, then A cannot be the parent of B.
cannot_be_parent_rule(A,B) :- sibling_rule(A,B). 

% If B is a sibling of A, then A cannot be the parent of B.
cannot_be_parent_rule(A,B) :- sibling_rule(B,A).

% If A is a child of B, then A cannot be the parent of B.
cannot_be_parent_rule(A,B) :- child_rule(A,B).

% If B is the parent of A, then A cannot be the parent of B.
cannot_be_parent_rule(A,B) :- parent_rule(B,A).

% If B is the grandparent of A, then A cannot be the parent of B.
cannot_be_parent_rule(A,B) :- grandparent_rule(B,A).

% If A is the grandparent of B, then A cannot be the parent of B.
cannot_be_parent_rule(A,B) :- grandparent_rule(A,B).

% If A is a pibling of B, then A cannot be the parent of B.
cannot_be_parent_rule(A,B) :- pibling_rule(A,B).

% If B is a pibling of A, then A cannot be the parent of B.
cannot_be_parent_rule(A,B) :- pibling_rule(B,A).

% If A is equal to B, then A cannot be the parent of B.
cannot_be_parent_rule(A,B) :- A == B.


% Daughter

% If A is not equal to B and it is stated that A is the daughter of B, then A is the daughter of B.
daughter_rule(A,B) :- \+ A == B, daughter_declaration(A,B).

% If A is the parent of B, then A cannot be the daughter of B.
cannot_be_daughter_rule(A,B) :- parent_rule(A,B).

% If A is a sibling of B, then A cannot be the daughter of B.
cannot_be_daughter_rule(A,B) :- sibling_rule(A,B). 

% If B is a sibling of A, then A cannot be the daughter of B.
cannot_be_daughter_rule(A,B) :- sibling_rule(B,A).

% If A is the son of B, then A cannot be the daughter of B.
cannot_be_daughter_rule(A,B) :- son_rule(A,B).

% If B is the child of A, then A cannot be the daughter of B.
cannot_be_daughter_rule(A,B) :- child_rule(B,A).

% If B is the grandparent of A, then A cannot be the daughter of B.
cannot_be_daughter_rule(A,B) :- grandparent_rule(B,A).

% If A is the grandparent of B, then A cannot be the daughter of B.
cannot_be_daughter_rule(A,B) :- grandparent_rule(A,B).

% If A is a pibling of B, then A cannot be the daughter of B.
cannot_be_daughter_rule(A,B) :- pibling_rule(A,B).

% If B is a pibling of A, then A cannot be the daughter of B.
cannot_be_daughter_rule(A,B) :- pibling_rule(B,A).

% If A is equal to B, then A cannot be the daughter of B.
cannot_be_daughter_rule(A,B) :- A == B.


% Son

% If A is not equal to B and it is stated that A is the son of B, then A is the son of B.
son_rule(A,B) :- \+ A == B, son_declaration(A,B).

% If A is a female, or A is not a male, A cannot be the son of B.
cannot_be_son_rule(A,_) :- female_rule(A); \+ male_rule(A).

% If A is the parent of B, then A cannot be the son of B.
cannot_be_son_rule(A,B) :- parent_rule(A,B).

% If A is a sibling of B, then A cannot be the son of B.
cannot_be_son_rule(A,B) :- sibling_rule(A,B). 

% If B is a sibling of A, then A cannot be the son of B.
cannot_be_son_rule(A,B) :- sibling_rule(B,A).

% If A is the daughter of B, then A cannot be the son of B.
cannot_be_son_rule(A,B) :- daughter_rule(A,B).

% If B is the child of A, then A cannot be the son of B.
cannot_be_son_rule(A,B) :- child_rule(B,A).

% If B is the grandparent of A, then A cannot be the son of B.
cannot_be_son_rule(A,B) :- grandparent_rule(B,A).

% If A is the grandparent of B, then A cannot be the son of B.
cannot_be_son_rule(A,B) :- grandparent_rule(A,B).

% If A is a pibling of B, then A cannot be the son of B.
cannot_be_son_rule(A,B) :- pibling_rule(A,B).

% If B is a pibling of A, then A cannot be the son of B.
cannot_be_son_rule(A,B) :- pibling_rule(B,A).

% If A is equal to B, then A cannot be the son of B.
cannot_be_son_rule(A,B) :- A == B.


% Child

% If A is not equal to B and it is stated that A is a child of B, then A is a child of B.
child_rule(A,B) :- \+ A == B, child_declaration(A,B).

% If A is a sibling of B, then A cannot be the child of B.
cannot_be_child_rule(A,B) :- sibling_rule(A,B). 

% If B is a sibling of A, then A cannot be the child of B.
cannot_be_child_rule(A,B) :- sibling_rule(B,A).

% If A is the child of B, then A cannot be the child of B.
cannot_be_child_rule(A,B) :- child_rule(B,A).

% If A is the parent of B, then A cannot be the child of B.
cannot_be_child_rule(A,B) :- parent_rule(A,B).

% If B is the grandparent of A, then A cannot be the child of B.
cannot_be_child_rule(A,B) :- grandparent_rule(B,A).

% If A is the grandparent of B, then A cannot be the child of B.
cannot_be_child_rule(A,B) :- grandparent_rule(A,B).

% If A is a pibling of B, then A cannot be the child of B.
cannot_be_child_rule(A,B) :- pibling_rule(A,B).

% If B is a pibling of A, then A cannot be the child of B.
cannot_be_child_rule(A,B) :- pibling_rule(B,A).

% If A is equal to B, then A cannot be the child of B.
cannot_be_child_rule(A,B) :- A == B.


% Brother

% If A is not equal to B and it is stated that A is the brother of B, then A is the brother of B.
brother_rule(A,B) :- \+ A == B, brother_declaration(A,B).

% If A is a female or not a male, A cannot be the brother of B.
cannot_be_brother_rule(A,_) :- female_rule(A); \+ male_rule(A).

% If A is the parent of B, then A cannot be the brother of B.
cannot_be_brother_rule(A,B) :- parent_rule(A,B).

% If B is the parent of A, then A cannot be the brother of B.
cannot_be_brother_rule(A,B) :- parent_rule(B,A). 

% If A is the child of B, then A cannot be the brother of B.
cannot_be_brother_rule(A,B) :- child_rule(A,B).

% If B is the child of A, then A cannot be the brother of B.
cannot_be_brother_rule(A,B) :- child_rule(B,A).

% If B is the grandparent of A, then A cannot be the brother of B.
cannot_be_brother_rule(A,B) :- grandparent_rule(B,A).

% If A is the grandparent of B, then A cannot be the brother of B.
cannot_be_brother_rule(A,B) :- grandparent_rule(A,B).

% If A is a pibling of B, then A cannot be the brother of B.
cannot_be_brother_rule(A,B) :- pibling_rule(A,B).

% If B is a pibling of A, then A cannot be the brother of B.
cannot_be_brother_rule(A,B) :- pibling_rule(B,A).

% If A is the sister of B, then A cannot be the brother of B.
cannot_be_brother_rule(A,B) :- sister_rule(A,B).

% If A is equal to B, then A cannot be the brother of B.
cannot_be_brother_rule(A,B) :- A == B.


% Sister

% If A is not equal to B and it is stated that A is the sister of B, then A is the sister of B.
sister_rule(A,B) :- \+ A == B, brother_declaration(A,B).

% If A is not a female or is a male, A cannot be the sister of B.
cannot_be_sister_rule(A,_) :- \+ female_rule(A); male_rule(A).

% If A is the parent of B, then A cannot be the sister of B.
cannot_be_sister_rule(A,B) :- parent_rule(A,B).

% If B is the parent of A, then A cannot be the sister of B.
cannot_be_sister_rule(A,B) :- parent_rule(B,A). 

% If A is the child of B, then A cannot be the sister of B.
cannot_be_sister_rule(A,B) :- child_rule(A,B).

% If B is the child of A, then A cannot be the sister of B.
cannot_be_sister_rule(A,B) :- child_rule(B,A).

% If B is the grandparent of A, then A cannot be the sister of B.
cannot_be_sister_rule(A,B) :- grandparent_rule(B,A).

% If A is the grandparent of B, then A cannot be the sister of B.
cannot_be_sister_rule(A,B) :- grandparent_rule(A,B).

% If A is a pibling of B, then A cannot be the sister of B.
cannot_be_sister_rule(A,B) :- pibling_rule(A,B).

% If B is a pibling of A, then A cannot be the sister of B.
cannot_be_sister_rule(A,B) :- pibling_rule(B,A).

% If A is the brother of B, then A cannot be the sister of B.
cannot_be_sister_rule(A,B) :- brother_rule(A,B).

% If A is equal to B, then A cannot be the sister of B.
cannot_be_sister_rule(A,B) :- A == B.


% Sibling

% If A is not equal to B and it is stated that A is a sibling of B, then A is a sibling of B.
sibling_rule(A,B) :- \+ A == B, sibling_declaration(A,B).

% If A is not equal to B and it is stated that A is a sibling of B, then B is a sibling of A.
sibling_rule(B,A) :- \+ A == B, sibling_declaration(A,B).

% If A is the child of B, then A cannot be a sibling of B.
cannot_be_sibling_rule(A,B) :- child_rule(A,B). 

% If B is the parent of A, then A cannot be a sibling of B.
cannot_be_sibling_rule(A,B) :- parent_rule(B,A).

% If A is the child of B, then B cannot be a sibling of A.
cannot_be_sibling_rule(A,B) :- child_rule(B,A).

% If B is the parent of A, then B cannot be a sibling of A.
cannot_be_sibling_rule(A,B) :- parent_rule(A,B).

% If B is the grandparent of A, then A cannot be a sibling of B.
cannot_be_sibling_rule(A,B) :- grandparent_rule(B,A).

% If A is the grandparent of B, then A cannot be a sibling of B.
cannot_be_sibling_rule(A,B) :- grandparent_rule(A,B).

% If A is a pibling of B, then A cannot be a sibling of B.
cannot_be_sibling_rule(A,B) :- pibling_rule(A,B).

% If B is a pibling of A, then A cannot be a sibling of B.
cannot_be_sibling_rule(A,B) :- pibling_rule(B,A).

% If A is equal to B, then A cannot be a sibling of B.
cannot_be_sibling_rule(A,B) :- A == B.


% Grandfather

% If A is not equal to B and A is stated that A is the grandfather of B, then A is the grandfather of B.
grandfather_rule(A,B) :- \+ A == B, grandfather_declaration(A,B).

% If A is female or not a male, A cannot be the grandfather of B.
cannot_be_grandfather_rule(A,_) :- female_rule(A); \+ male_rule(A).

% If A is the parent of B, then A cannot be the grandfather of B.
cannot_be_grandfather_rule(A,B) :- parent_rule(A,B).

% If B is the parent of A, then A cannot be the grandfather of B.
cannot_be_grandfather_rule(A,B) :- parent_rule(B,A).

% If A is a sibling of B, then A cannot be the grandfather of B.
cannot_be_grandfather_rule(A,B) :- sibling_rule(A,B). 

% If B is a sibling of A, then A cannot be the grandfather of B.
cannot_be_grandfather_rule(A,B) :- sibling_rule(B,A).

% If A is the child of B, then A cannot be the grandfather of B.
cannot_be_grandfather_rule(A,B) :- child_rule(A,B).

% If B is the child of A, then A cannot be the grandfather of B.
cannot_be_grandfather_rule(A,B) :- child_rule(B,A).

% If B is the grandparent of A, then A cannot be the grandfather of B.
cannot_be_grandfather_rule(A,B) :- grandparent_rule(B,A).

% If A is the grandmother of B, then A cannot be the grandfather of B.
cannot_be_grandfather_rule(A,B) :- grandmother_rule(A,B).

% If A is a pibling of B, then A cannot be the grandfather of B.
cannot_be_grandfather_rule(A,B) :- pibling_rule(A,B).

% If B is a pibling of A, then A cannot be the grandfather of B.
cannot_be_grandfather_rule(A,B) :- pibling_rule(B,A).

% If A is equal to B, then A cannot be the grandfather of B.
cannot_be_grandfather_rule(A,B) :- A == B.


% Grandmother

% If A is not equal to B and it is stated that A is the grandmother of B, then A is the grandmother of B.
grandmother_rule(A,B) :- \+ A == B, grandmother_declaration(A,B).

% If A is not a female or is a male, A cannot be the grandmother of B.
cannot_be_grandmother_rule(A,_) :- \+ female_rule(A); male_rule(A).

% If A is the parent of B, then A cannot be the grandmother of B.
cannot_be_grandmother_rule(A,B) :- parent_rule(A,B).

% If B is the parent of A, then A cannot be the grandmother of B.
cannot_be_grandmother_rule(A,B) :- parent_rule(B,A).

% If A is a sibling of B, then A cannot be the grandmother of B.
cannot_be_grandmother_rule(A,B) :- sibling_rule(A,B). 

% If B is a sibling of A, then A cannot be the grandmother of B.
cannot_be_grandmother_rule(A,B) :- sibling_rule(B,A).

% If A is the child of B, then A cannot be the grandmother of B.
cannot_be_grandmother_rule(A,B) :- child_rule(A,B).

% If B is the child of A, then A cannot be the grandmother of B.
cannot_be_grandmother_rule(A,B) :- child_rule(B,A).

% If B is the grandparent of A, then A cannot be the grandmother of B.
cannot_be_grandmother_rule(A,B) :- grandparent_rule(B,A).

% If A is the grandfather of B, then A cannot be the grandmother of B.
cannot_be_grandmother_rule(A,B) :- grandfather_rule(A,B).

% If A is a pibling of B, then A cannot be the grandmother of B.
cannot_be_grandmother_rule(A,B) :- pibling_rule(A,B).

% If B is a pibling of A, then A cannot be the grandmother of B.
cannot_be_grandmother_rule(A,B) :- pibling_rule(B,A).

% If A is equal to B, then A cannot be the grandmother of B.
cannot_be_grandmother_rule(A,B) :- A == B.


% Grandparent

% If A is not equal to B and it is stated that A is a grandfather of B, then A is a grandparent of B.
grandparent_rule(A,B) :- \+ A == B, grandfather_declaration(A,B).

% If A is not equal to B and it is stated that A is a grandmother of B, then A is a grandparent of B.
grandparent_rule(A,B) :- \+ A == B, grandmother_declaration(A,B).


% Uncle

% If A is not equal to B and it is stated that A is an uncle of B, then A is an uncle of B.
uncle_rule(A,B) :- \+ A == B, uncle_declaration(A,B).

% If A is female or not a male, A cannot be the uncle of B.
cannot_be_uncle_rule(A,_) :- female_rule(A); \+ male_rule(A).

% If A is the parent of B, then A cannot be the uncle of B.
cannot_be_uncle_rule(A,B) :- parent_rule(A,B).

% If B is the parent of A, then A cannot be the uncle of B.
cannot_be_uncle_rule(A,B) :- parent_rule(B,A).

% If A is a sibling of B, then A cannot be the uncle of B.
cannot_be_uncle_rule(A,B) :- sibling_rule(A,B). 

% If B is a sibling of A, then A cannot be the uncle of B.
cannot_be_uncle_rule(A,B) :- sibling_rule(B,A).

% If A is the child of B, then A cannot be the uncle of B.
cannot_be_uncle_rule(A,B) :- child_rule(A,B).

% If B is the child of A, then A cannot be the uncle of B.
cannot_be_uncle_rule(A,B) :- child_rule(B,A).

% If B is the grandparent of A, then A cannot be the uncle of B.
cannot_be_uncle_rule(A,B) :- grandparent_rule(B,A).

% If A is the grandparent of B, then A cannot be the uncle of B.
cannot_be_uncle_rule(A,B) :- grandparent_rule(A,B).

% If A is the aunt of B, then A cannot be the uncle of B.
cannot_be_uncle_rule(A,B) :- aunt_rule(A,B).

% If B is a pibling of A, then A cannot be the uncle of B.
cannot_be_uncle_rule(A,B) :- pibling_rule(B,A).

% If A is equal to B, then A cannot be the uncle of B.
cannot_be_uncle_rule(A,B) :- A == B.


% Aunt

% If A is not equal to B and it is stated that A is an aunt of B, then A is an aunt of B.
aunt_rule(A,B) :- \+ A == B, aunt_declaration(A,B).

% If A is not a female or is a male, A cannot be the aunt of B.
cannot_be_aunt_rule(A,_) :- \+ female_rule(A); male_rule(A).

% If A is the parent of B, then A cannot be the aunt of B.
cannot_be_aunt_rule(A,B) :- parent_rule(A,B).

% If B is the parent of A, then A cannot be the aunt of B.
cannot_be_aunt_rule(A,B) :- parent_rule(B,A).

% If A is a sibling of B, then A cannot be the aunt of B.
cannot_be_aunt_rule(A,B) :- sibling_rule(A,B). 

% If B is a sibling of A, then A cannot be the aunt of B.
cannot_be_aunt_rule(A,B) :- sibling_rule(B,A).

% If A is the child of B, then A cannot be the aunt of B.
cannot_be_aunt_rule(A,B) :- child_rule(A,B).

% If B is the child of A, then A cannot be the aunt of B.
cannot_be_aunt_rule(A,B) :- child_rule(B,A).

% If B is the grandparent of A, then A cannot be the aunt of B.
cannot_be_aunt_rule(A,B) :- grandparent_rule(B,A).

% If A is the grandparent of B, then A cannot be the aunt of B.
cannot_be_aunt_rule(A,B) :- grandparent_rule(A,B).

% If A is the uncle of B, then A cannot be the aunt of B.
cannot_be_aunt_rule(A,B) :- uncle_rule(A,B).

% If B is a pibling of A, then A cannot be the aunt of B.
cannot_be_aunt_rule(A,B) :- pibling_rule(B,A).

% If A is equal to B, then A cannot be the aunt of B.
cannot_be_aunt_rule(A,B) :- A == B.


% Pibling

% If A is not equal to B and it is stated that A is an uncle of B, then A is a pibling of B.
pibling_rule(A,B) :- \+ A == B, uncle_declaration(A,B).

% If A is not equal to B and it is stated that A is an aunt of B, then A is a pibling of B.
pibling_rule(A,B) :- \+ A == B, aunt_declaration(A,B).


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

% mother_declaration(anna, charlie).
% father_declaration(bob, charlie).
% mother_declaration(anna, darwin).
% father_declaration(charlie, darwin).

same(X,Y) :- X == Y.
same(Y,X) :- X == Y.

female(X) :- mother_declaration(X,_).
female(X) :- daughter_declaration(X,_).
female(X) :- sister_declaration(X,_).
female(X) :- grandmother_declaration(X,_).
female(X) :- aunt_declaration(X,_).

not_female(X) :- \+ female(X).
not_female(X) :- male(X).

male(X) :- father_declaration(X,_).
male(X) :- son_declaration(X,_).
male(X) :- brother_declaration(X,_).
male(X) :- grandfather_declaration(X,_).
male(X) :- uncle_declaration(X,_).

not_male(X) :- \+ male(X).
not_male(X) :- female(X).

mother(X,Y) :- mother_declaration(X,Y).
mother(X,Y) :- female(X), parent(X,Y).
mother(X,Y) :- parent(X,Y), father_declaration(Z,Y), \+ X == Z.
mother(X,Y) :- parent(X,Y), male(Z), parent(Z,Y), \+ X == Z. 

has_mother(X) :- mother(_,X).

not_mother(X,_) :- not_female(X).
not_mother(X,Y) :- not_parent(X,Y).

father(X,Y) :- father_declaration(X,Y).
father(X,Y) :- male(X), parent(X,Y).
father(X,Y) :- parent(X,Y), mother_declaration(Z,Y), \+ X == Z.
father(X,Y) :- parent(X,Y), female(Z), parent(Z,Y), \+ X == Z.

has_father(X) :- father(_,X).

not_father(X,_) :- not_male(X).
not_father(X,Y) :- not_parent(X,Y).

parent(X,Y) :- mother_declaration(X,Y).
parent(X,Y) :- father_declaration(X,Y).
parent(X,Y) :- parent_declaration(X,Y).
parent(X,Y) :- son_declaration(Y,X).
parent(X,Y) :- daughter_declaration(Y,X).
parent(X,Y) :- child_declaration(Y,X).

has_two_parents(X) :- parent(Y,X), parent(Z, X), \+ Y == Z. 

daughter(X,Y) :- daughter_declaration(X,Y).
daughter(X,Y) :- female(X), child(X,Y).

not_daughter(X,_) :- not_female(X).
not_daughter(X,Y) :- not_child(X,Y).

son(X,Y) :- son_declaration(X,Y).
son(X,Y) :- male(X), child(X,Y).

not_son(X,_) :- not_male(X).
not_son(X,Y) :- not_child(X,Y).

child(X,Y) :- son_declaration(X,Y).
child(X,Y) :- daughter_declaration(X,Y).
child(X,Y) :- child_declaration(X,Y).
child(X,Y) :- mother_declaration(Y,X).
child(X,Y) :- father_declaration(Y,X).
child(X,Y) :- parent_declaration(Y,X).

sister(X,Y) :- sister_declaration(X,Y).
sister(X,Y) :- female(X), (sibling(X,Y); sibling(Y,X)).

not_sister(X,_) :- not_female(X).
not_sister(X,Y) :- not_sibling(X,Y).

brother(X,Y) :- brother_declaration(X,Y).
brother(X,Y) :- male(X), (sibling(X,Y); sibling(Y,X)).

not_brother(X,_) :- not_male(X).
not_brother(X,Y) :- not_sibling(X,Y).

sibling(X,Y) :- sibling_declaration(X,Y).
sibling(Y,X) :- sibling_declaration(X,Y).
sibling(X,Y) :- sibling_declaration(Y,X).
sibling(Y,X) :- sibling_declaration(Y,X).

sibling(X,Y) :- parent(Z,X), parent(Z,Y).

grandmother(X,Y) :- grandmother_declaration(X,Y).
grandmother(X,Y) :- female(X), grandparent(X,Y).

not_grandmother(X,_) :- not_female(X).
not_grandmother(X,Y) :- not_grandparent(X,Y).

grandfather(X,Y) :- grandfather_declaration(X,Y).
grandfather(X,Y) :- male(X), grandparent(X,Y).

not_grandfather(X,_) :- not_male(X).
not_grandfather(X,Y) :- not_grandparent(X,Y).

grandparent(X,Y) :- grandmother_declaration(X,Y).
grandparent(X,Y) :- grandfather_declaration(X,Y).
grandparent(X,Y) :- parent(X,Z), parent(Z,Y).

aunt(X,Y) :- aunt_declaration(X,Y).
aunt(X,Y) :- female(X), pibling(X,Y).

not_aunt(X,_) :- not_female(X).
not_aunt(X,Y) :- not_pibling(X,Y).

uncle(X,Y) :- uncle_declaration(X,Y).
uncle(X,Y) :- male(X), pibling(X,Y).

not_uncle(X,_) :- not_male(X).
not_uncle(X,Y) :- not_pibling(X,Y).

pibling(X,Y) :- aunt_declaration(X,Y).
pibling(X,Y) :- uncle_declaration(X,Y).
pibling(X,Y) :- parent(Z,Y), (sibling(X,Z); sibling(Z,X)).

predecessor_declaration(X,Y) :- parent(X,Y).
predecessor_declaration(X,Y) :- pibling(X,Y).
predecessor_declaration(X,Y) :- grandparent(X,Y).

predecessor(X,Y) :- predecessor_declaration(X,Z), predecessor(Z,Y).
predecessor(X,Y) :- predecessor_declaration(X,Y).

descendant_declaration(X,Y) :- child(X,Y).
descendant_declaration(X,Y) :- pibling(Y,X).
descendant_declaration(X,Y) :- grandparent(Y,X).

descendant(X,Y) :- descendant_declaration(X,Z), descendant(Z,Y).
descendant(X,Y) :- descendant_declaration(Z,Y).

relative_declaration(X,Y) :- predecessor(X,Y).
relative_declaration(X,Y) :- descendant(X,Y).
relative_declaration(X,Y) :- (sibling(X,Y); sibling(Y,X)).
relative_declaration(X,Y) :- predecessor(Z,X), descendant(Y,Z). 

relative(X,Y) :- relative_declaration(X,Y).
relative(Y,X) :- relative_declaration(X,Y).
relative(X,Y) :- relative_declaration(Y,X).
relative(Y,X) :- relative_declaration(Y,X).

not_relative(X,Y) :- \+ relative(X,Y).
not_relative(Y,X) :- \+ relative(X,Y).
not_relative(X,Y) :- \+ relative(Y,X).
not_relative(Y,X) :- \+ relative(Y,X).

not_parent(X,Y) :- same(X,Y).
not_parent(X,Y) :- descendant(X,Y).
not_parent(X,Y) :- predecessor(X,Z), predecessor(Z,Y).
not_parent(X,Y) :- sibling(X,Y).

not_child(X,Y) :- same(X,Y).
not_child(X,Y) :- predecessor(X,Y).
not_child(X,Y) :- descendant(X,Z), descendant(Z,Y).
not_child(X,Y) :- sibling(X,Y).

not_sibling(X,Y) :- same(X,Y).
not_sibling(X,Y) :- predecessor(X,Y).
not_sibling(X,Y) :- descendant(X,Y).

not_grandparent(X,Y) :- same(X,Y).
not_grandparent(X,Y) :- descendant(X,Y).
not_grandparent(X,Y) :- parent(X,Y).
not_grandparent(X,Y) :- sibling(X,Y).
not_grandparent(X,Y) :- pibling(X,Y).
not_grandparent(X,Y) :- descendant(X,Z), grandparent(Z,Y).

not_pibling(X,Y) :- same(X,Y).
not_pibling(X,Y) :- descendant(X,Y).
not_pibling(X,Y) :- sibling(X,Y).
not_pibling(X,Y) :- parent(X,Y).
not_pibling(X,Y) :- descendant(X,Z), parent(Z,Y).

maybe_mother(X,Y) :- \+ mother(X,Y), \+ not_mother(X,Y).
maybe_father(X,Y) :- \+ father(X,Y), \+ not_father(X,Y).
maybe_parent(X,Y) :- \+ parent(X,Y), \+ not_parent(X,Y).
maybe_son(X,Y) :- \+ son(X,Y), \+ not_son(X,Y).
maybe_daughter(X,Y) :- \+ daughter(X,Y), \+ not_daughter(X,Y).
maybe_child(X,Y) :- \+ child(X,Y), \+ not_child(X,Y).
maybe_brother(X,Y) :- \+ brother(X,Y), \+ not_brother(X,Y).
maybe_sister(X,Y) :- \+ sister(X,Y), \+ not_sister(X,Y).
maybe_sibling(X,Y) :- \+ sibling(X,Y), \+ not_sibling(X,Y).
maybe_aunt(X,Y) :- \+ aunt(X,Y), \+ not_aunt(X,Y).
maybe_uncle(X,Y) :- \+ uncle(X,Y), \+ not_aunt(X,Y).
maybe_grandfather(X,Y) :- \+ grandfather(X,Y), \+ not_grandfather(X,Y).
maybe_grandmother(X,Y) :- \+ grandmother(X,Y), \+ not_grandmother(X,Y).

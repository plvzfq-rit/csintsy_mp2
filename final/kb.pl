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

exists(X) :- father_declaration(X,_).
exists(X) :- father_declaration(_,X).
exists(X) :- mother_declaration(X,_).
exists(X) :- mother_declaration(_,X).
exists(X) :- parent_declaration(X,_).
exists(X) :- parent_declaration(_,X).
exists(X) :- brother_declaration(X,_).
exists(X) :- brother_declaration(_,X).
exists(X) :- sister_declaration(X,_).
exists(X) :- sister_declaration(_,X).
exists(X) :- sibling_declaration(X,_).
exists(X) :- sibling_declaration(_,X).
exists(X) :- son_declaration(X,_).
exists(X) :- son_declaration(_,X).
exists(X) :- daughter_declaration(X,_).
exists(X) :- daughter_declaration(_,X).
exists(X) :- child_declaration(X,_).
exists(X) :- child_declaration(_,X).
exists(X) :- uncle_declaration(X,_).
exists(X) :- uncle_declaration(_,X).
exists(X) :- aunt_declaration(X,_).
exists(X) :- aunt_declaration(_,X).
exists(X) :- grandfather_declaration(X,_).
exists(X) :- grandfather_declaration(_,X).
exists(X) :- grandmother_declaration(X,_).
exists(X) :- grandmother_declaration(_,X).

same(X,Y) :- X == Y.
same(Y,X) :- X == Y.

female(X) :- mother_declaration(X,_).
female(X) :- daughter_declaration(X,_).
female(X) :- sister_declaration(X,_).
female(X) :- grandmother_declaration(X,_).
female(X) :- aunt_declaration(X,_).

not_female(X) :- male(X), exists(X).

male(X) :- father_declaration(X,_).
male(X) :- son_declaration(X,_).
male(X) :- brother_declaration(X,_).
male(X) :- grandfather_declaration(X,_).
male(X) :- uncle_declaration(X,_).

not_male(X) :- female(X), exists(X).

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
has_parent(X) :- parent(_,X).

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
sibling(X,Y) :- brother_declaration(X,Y).
sibling(Y,X) :- brother_declaration(X,Y).
sibling(X,Y) :- brother_declaration(Y,X).
sibling(Y,X) :- brother_declaration(Y,X).
sibling(X,Y) :- sister_declaration(X,Y).
sibling(Y,X) :- sister_declaration(X,Y).
sibling(X,Y) :- sister_declaration(Y,X).
sibling(Y,X) :- sister_declaration(Y,X).
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
descendant(X,Y) :- descendant_declaration(X,Y).

relative_declaration(X,Y) :- predecessor(X,Y).
relative_declaration(X,Y) :- descendant(X,Y).
relative_declaration(X,Y) :- (sibling(X,Y); sibling(Y,X)).
relative_declaration(X,Y) :- predecessor(Z,X), descendant(Y,Z). 

relative(X,Y) :- relative_declaration(X,Y).
relative(X,Y) :- relative_declaration(Y,X).

not_relative(X,Y) :- \+ relative(X,Y).
not_relative(X,Y) :- \+ relative(Y,X).

named_relation(X,Y) :- sibling(X,Y).
named_relation(X,Y) :- parent(X,Y).
named_relation(X,Y) :- child(X,Y).
named_relation(X,Y) :- grandparent(X,Y).
named_relation(X,Y) :- pibling(X,Y).

haram(X,Y) :- grandparent(Z,X), sibling(Z,Y).
haram(X,Y) :- grandparent(Z,X), parent(Z,Y).
haram(X,Y) :- pibling(Z,X), parent(Z,Y).
haram(X,Y) :- parent(Z,X), child(Z,Y).
haram(X,Y) :- child(Z,X), child(Z,Y).
haram(X,Y) :- grandparent(Z,X), child(Z,Y).
haram(X,Y) :- pibling(Z,X), child(Z,Y).
haram(X,Y) :- parent(Z,X), sibling(Z,Y).
haram(X,Y) :- sibling(Z,X), grandparent(Z,Y).
haram(X,Y) :- parent(Z,X), pibling(Z,Y).
haram(X,Y) :- grandparent(Z,X), pibling(Z,Y).

haram(X,Y) :- child(X,Z), sibling(Z,Y).
haram(X,Y) :- grandparent(X,Z), parent(Z,Y).
haram(X,Y) :- grandparent(X,Z), pibling(Z,Y).
haram(X,Y) :- sibling(X,Z), child(Z,Y).
haram(X,Y) :- parent(X,Z), child(Z,Y).
haram(X,Y) :- child(X,Z), child(Z,Y).
haram(X,Y) :- parent(X,Z), grandparent(Z,Y).
haram(X,Y) :- grandparent(X,Z), grandparent(Z,Y).
haram(X,Y) :- pibling(X,Z), grandparent(Z,Y).
haram(X,Y) :- child(X,Z), pibling(Z,Y).
haram(X,Y) :- grandparent(X,Z), pibling(Z,Y).
haram(X,Y) :- pibling(X,Z), pibling(Z,Y).

haram(X,Y) :- sibling(X,Z), parent(Y,Z).
haram(X,Y) :- parent(X,Z), parent(Y,Z).
haram(X,Y) :- child(X,Z), parent(Y,Z).
haram(X,Y) :- grandparent(X,Z), child(Y,Z).
haram(X,Y) :- pibling(X,Z), child(Y,Z).
haram(X,Y) :- sibling(X,Z), grandparent(Y,Z).
haram(X,Y) :- child(X,Z), grandparent(Y,Z).
haram(X,Y) :- grandparent(X,Z), grandparent(Y,Z).
haram(X,Y) :- pibling(X,Z), grandparent(Y,Z).
haram(X,Y) :- sibling(X,Z), pibling(Y,Z).
haram(X,Y) :- child(X,Z), pibling(Y,Z).
haram(X,Y) :- grandparent(X,Z), pibling(Y,Z).

haram(X,Y) :- parent(Z,X), parent(Y,Z).
haram(X,Y) :- parent(Z,X), grandparent(Y,Z).
haram(X,Y) :- parent(Z,X), pibling(Y,Z).
haram(X,Y) :- child(Z,X), parent(Y,Z).
haram(X,Y) :- child(Z,X), grandparent(Y,Z).
haram(X,Y) :- grandparent(Z,X), parent(Y,Z).
haram(X,Y) :- grandparent(Z,X), child(Y,Z).
haram(X,Y) :- grandparent(Z,X), grandparent(Y,Z).
haram(X,Y) :- pibling(Z,X), parent(Y,Z).
haram(X,Y) :- pibling(Z,X), child(Y,Z).
haram(X,Y) :- pibling(Z,X), grandparent(Y,Z).
haram(X,Y) :- pibling(Z,X), pibling(Y,Z).


not_parent(X,Y) :- same(X,Y).
not_parent(X,Y) :- haram(X,Y).
not_parent(X,Y) :- descendant(X,Y).
not_parent(X,Y) :- predecessor(X,Z), predecessor(Z,Y).
not_parent(X,Y) :- sibling(X,Y).
not_parent(X,Y) :- pibling(X,Y).
not_parent(X,Y) :- grandparent(X,Y).
not_parent(X,Y) :- predecessor(Z,X), descendant(Z,Y). 
not_parent(X,Y) :- grandparent(Z,X), named_relation(Z,Y).
not_parent(X,Y) :- pibling(Z,X), named_relation(Z,Y).
not_parent(X,Y) :- named_relation(Z,X), parent(Z,Y).
not_parent(X,Y) :- named_relation(Z,X), child(Z,Y).
not_parent(X,Y) :- sibling(Z,X), sibling(Z,Y).
not_parent(X,Y) :- child(Z,X), pibling(Z,Y).
not_parent(X,Y) :- pibling(X,Z), named_relation(Z,Y).
not_parent(X,Y) :- sibling(X,Z), sibling(Z,Y).
not_parent(X,Y) :- grandparent(X,Z), sibling(Z,Y).
not_parent(X,Y) :- sibling(X,Z), grandparent(Z,Y).
not_parent(X,Y) :- parent(X,Z), pibling(Z,Y).
not_parent(X,Y) :- named_relation(X,Z), parent(Y,Z).
not_parent(X,Y) :- named_relation(X,Z), grandparent(Y,Z).
not_parent(X,Y) :- named_relation(X,Z), pibling(Y,Z).
not_parent(X,Y) :- child(Z,X), pibling(Y,Z).
not_parent(X,Y) :- grandparent(Z,X), pibling(Y,Z).

not_child(X,Y) :- same(X,Y).
not_child(X,Y) :- haram(X,Y).
not_child(X,Y) :- predecessor(X,Y).
not_child(X,Y) :- descendant(X,Z), descendant(Z,Y).
not_child(X,Y) :- sibling(X,Y).
not_child(X,Y) :- descendant(Z,X), predecessor(Z,Y).
not_child(X,Y) :- sibling(Z,X), sibling(Z,Y).
not_child(X,Y) :- named_relation(Z,X), grandparent(Z,Y).
not_child(X,Y) :- named_relation(Z,X), pibling(Z,Y).
not_child(X,Y) :- named_relation(X,Z), named_relation(Z,Y).
not_child(X,Y) :- named_relation(X,Z), parent(Y,Z).
not_child(X,Y) :- named_relation(X,Z), pibling(Y,Z).
not_child(X,Y) :- child(Z,X), pibling(Y,Z).
not_child(X,Y) :- grandparent(Z,X), pibling(Y,Z).

not_sibling_declaration(X,Y) :- same(X,Y).
not_sibling_declaration(X,Y) :- haram(Y,X).
not_sibling_declaration(X,Y) :- predecessor(X,Y).
not_sibling_declaration(X,Y) :- predecessor(Y,X).
not_sibling_declaration(X,Y) :- descendant(X,Y).
not_sibling_declaration(X,Y) :- descendant(Y,X).
not_sibling_declaration(X,Y) :- sibling(Z,X), predecessor(Y,Z).
not_sibling_declaration(X,Y) :- sibling(Z,Y), predecessor(X,Z).
not_sibling_declaration(X,Y) :- sibling(Z,X), descendant(Y,Z).
not_sibling_declaration(X,Y) :- sibling(Z,Y), descendant(X,Z).
not_sibling_declaration(X,Y) :- child(Z,X), named_relation(Z,Y).
not_sibling_declaration(X,Y) :- child(Z,Y), named_relation(Z,X).
not_sibling_declaration(X,Y) :- pibling(Z,X), sibling(Z,Y).
not_sibling_declaration(X,Y) :- pibling(Z,Y), sibling(Z,X).
not_sibling_declaration(X,Y) :- parent(Z,X), grandparent(Z,Y).
not_sibling_declaration(X,Y) :- parent(Z,Y), grandparent(Z,X).
not_sibling_declaration(X,Y) :- pibling(Z,X), grandparent(Z,Y).
not_sibling_declaration(X,Y) :- pibling(Z,Y), grandparent(Z,X).
not_sibling_declaration(X,Y) :- parent(X,Z), named_relation(Z,Y).
not_sibling_declaration(X,Y) :- parent(Y,Z), named_relation(Z,X).
not_sibling_declaration(X,Y) :- grandparent(X,Z), named_relation(Z,Y).
not_sibling_declaration(X,Y) :- grandparent(Y,Z), named_relation(Z,X).
not_sibling_declaration(X,Y) :- named_relation(X,Z), grandparent(Z,Y).
not_sibling_declaration(X,Y) :- named_relation(Y,Z), grandparent(Z,X).
not_sibling_declaration(X,Y) :- named_relation(X,Z), pibling(Z,Y).
not_sibling_declaration(X,Y) :- named_relation(Y,Z), pibling(Z,X).
not_sibling_declaration(X,Y) :- pibling(X,Z), sibling(Z,Y).
not_sibling_declaration(X,Y) :- pibling(Y,Z), sibling(Z,X).
not_sibling_declaration(X,Y) :- grandparent(X,Z), parent(Y,Z).
not_sibling_declaration(X,Y) :- grandparent(Y,Z), parent(X,Z).
not_sibling_declaration(X,Y) :- parent(X,Z), grandparent(Y,Z).
not_sibling_declaration(X,Y) :- parent(Y,Z), grandparent(X,Z).

not_sibling(X,Y) :- not_sibling_declaration(X,Y).
not_sibling(Y,X) :- not_sibling_declaration(X,Y).

not_grandparent(X,Y) :- same(X,Y).
not_grandparent(X,Y) :- haram(X,Y).
not_grandparent(X,Y) :- descendant(X,Y).
not_grandparent(X,Y) :- parent(X,Y).
not_grandparent(X,Y) :- sibling(X,Y).
not_grandparent(X,Y) :- pibling(X,Y).
not_grandparent(X,Y) :- descendant(X,Z), grandparent(Z,Y).
not_grandparent(X,Y) :- named_relation(Z,X), sibling(Z,Y).
not_grandparent(X,Y) :- named_relation(Z,X), parent(Z,Y).
not_grandparent(X,Y) :- named_relation(Z,X), child(Z,Y).
not_grandparent(X,Y) :- named_relation(Z,X), grandparent(Z,Y).
not_grandparent(X,Y) :- sibling(Z,X), named_relation(Z,Y).
not_grandparent(X,Y) :- pibling(Z,X), named_relation(Z,Y).
not_grandparent(X,Y) :- sibling(X,Z), sibling(Z,Y).
not_grandparent(X,Y) :- parent(X,Z), sibling(Z,Y).
not_grandparent(X,Y) :- pibling(X,Z), sibling(Z,Y).
not_grandparent(X,Y) :- sibling(X,Z), pibling(Z,Y).
not_grandparent(X,Y) :- child(X,Z), named_relation(Z,Y).
not_grandparent(X,Y) :- named_relation(X,Z), child(Z,Y).
not_grandparent(X,Y) :- named_relation(X,Z), grandparent(Y,Z).
not_grandparent(X,Y) :- named_relation(X,Z), pibling(Y,Z).
not_grandparent(X,Y) :- pibling(X,Z), parent(Y,Z).
not_grandparent(X,Y) :- child(Z,X), pibling(Y,Z).
not_grandparent(X,Y) :- grandparent(Z,X), pibling(Y,Z).

not_pibling(X,Y) :- same(X,Y).
not_pibling(X,Y) :- haram(X,Y).
not_pibling(X,Y) :- descendant(X,Y).
not_pibling(X,Y) :- sibling(X,Y).
not_pibling(X,Y) :- parent(X,Y).
not_pibling(X,Y) :- grandparent(X,Y).
not_pibling(X,Y) :- descendant(X,Z), parent(Z,Y).
not_pibling(X,Y) :- named_relation(Z,X), sibling(Z,Y).
not_pibling(X,Y) :- grandparent(Z,X), named_relation(Z,Y).
not_pibling(X,Y) :- child(Z,X), parent(Z,Y).
not_pibling(X,Y) :- sibling(Z,X), child(Z,Y).
not_pibling(X,Y) :- child(Z,X), pibling(Z,Y).
not_pibling(X,Y) :- pibling(Z,X), pibling(Z,Y).
not_pibling(X,Y) :- pibling(X,Z), named_relation(Z,Y).
not_pibling(X,Y) :- named_relation(X,Z), child(Z,Y).
not_pibling(X,Y) :- sibling(X,Z), sibling(Z,Y).
not_pibling(X,Y) :- sibling(X,Z), grandparent(Z,Y).
not_pibling(X,Y) :- named_relation(X,Z), parent(Y,Z).
not_pibling(X,Y) :- named_relation(X,Z), grandparent(Y,Z).
not_pibling(X,Y) :- named_relation(X,Z), pibling(Y,Z).
not_pibling(X,Y) :- child(Z,X), pibling(Y,Z).
not_pibling(X,Y) :- grandparent(Z,X), pibling(Y,Z).

maybe_mother(X,Y) :- \+ mother(X,Y); \+ not_mother(X,Y), \+ same(X,Y).
maybe_father(X,Y) :- \+ father(X,Y), \+ not_father(X,Y), \+ same(X,Y).
maybe_parent(X,Y) :- \+ parent(X,Y), \+ not_parent(X,Y), \+ same(X,Y).
maybe_son(X,Y) :- \+ son(X,Y), \+ not_son(X,Y), \+ same(X,Y).
maybe_daughter(X,Y) :- \+ daughter(X,Y), \+ not_daughter(X,Y), \+ same(X,Y).
maybe_child(X,Y) :- \+ child(X,Y), \+ not_child(X,Y), \+ same(X,Y).
maybe_brother(X,Y) :- \+ brother(X,Y), \+ not_brother(X,Y), \+ same(X,Y).
maybe_sister(X,Y) :- \+ sister(X,Y), \+ not_sister(X,Y), \+ same(X,Y).
maybe_sibling(X,Y) :- \+ sibling(X,Y), \+ not_sibling(X,Y), \+ same(X,Y).
maybe_aunt(X,Y) :- \+ aunt(X,Y), \+ not_aunt(X,Y), \+ same(X,Y).
maybe_uncle(X,Y) :- \+ uncle(X,Y), \+ not_aunt(X,Y), \+ same(X,Y).
maybe_grandfather(X,Y) :- \+ grandfather(X,Y), \+ not_grandfather(X,Y), \+ same(X,Y).
maybe_grandmother(X,Y) :- \+ grandmother(X,Y), \+ not_grandmother(X,Y), \+ same(X,Y).

father_declaration(fill,fill).
mother_declaration(fill,fill).
brother_declaration(fill,fill).
aunt_declaration(fill,fill).
son_declaration(fill,fill).
uncle_declaration(fill,fill).
parent_declaration(fill,fill).
sibling_declaration(fill,fill).
sister_declaration(fill,fill).
brother_declaration(fill,fill).
male_rule(fill).
female_rule(fill).
child_declaration(fill,fill).

mother_declaration(anna, charlie).
father_declaration(bob,charlie).
mother_declaration(anna,darwin).
father_declaration(charlie,darwin).

% sibling rules --should be done

    % 1. X and Y are siblings if they share a parent
    siblings(X,Y) :- (parent_declaration(Z,X), parent_declaration(Z,Y), X \= Y);

    % 2. siblings are commutative and, X and Y are not the same person
    (sibling_declaration(Y,X) , X \= Y);

    % 3. X and Y are siblings if X is the sister of Y, and X and Y are not the same person
    ( sister_declaration(X,Y) , X \= Y);

    % 4. X and Y are siblings if Y is the sister of X and, X and Y are not the same person
    (sister_declaration(Y,X) , X \= Y);

    % 5. X and Y are siblings if X is the brother of Y and, X and Y are not the same person
    ( brother_declaration(X,Y) , X \= Y);

    % 6. X and Y are siblings if Y is the sister of X and, X and Y are not the same person
    ( brother_declaration(Y,X) , X \= Y).



% sister rules

    % X is the sister of Y if X and Y are siblings, X is a girl, and X and Y are not the same person
    sister(X,Y) :- sister_declaration(X,Y);
                   siblings(X,Y), female_rule(X), X \= Y.



% brother rules

    % X is the brother of Y if X and Y are siblings, X is a boy, and X and Y are not the same person
    brother(X,Y) :- brother_declaration(X,Y);
                    siblings(X,Y), male_rule(X), X \= Y.

% parent rules

    % X is the parent of Y if X is the mother of Y
    parent(X,Y) :- parent_declaration(X,Y).

    % X is the parent of Y if X is the mother of Y
    parent(X,Y) :- mother_declaration(X,Y).

    % X is the parent of Y if X is the father of Y
    parent(X,Y) :- father_declaration(X,Y).

    % X is the parent of Y if Y is the child of X
    parent(X,Y):- child_declaration(Y,X).

    % X is the parent of Y if Y is the son of X
    parent(X,Y):- son_declaration(Y,X).

    % X is the parent of Y if Y is the daughter of X
    parent(X,Y):- daughter_declaration(Y,X).


% grandparent rules

    % X is the grandparent of Y if X is the parent of Z, and Z is the parent of Y
    grandparent(X,Y) :- parent(X,Z), parent(Z,Y).

% grandfather rules

    % X is the grandfather of Y if X is a grandparent of Y, and X is a male
    grandfather(X,Y) :- grandparent(X,Y), male_rule(X);

    % X is a grandfather of Y if X is a grandfather of Y
    grandfather_declaration(X,Y).

% grandmother rules

    % X is the grandmother of Y if X is a grandparent of Y, and X is a female
    grandmother(X,Y) :- grandparent(X,Y), female_rule(X);

    % X is a grandmother of Y if X is a grandmother of Y
    grandmother_declaration(X,Y).

% mother rules

    % X is the mother of Y if X is the parent of Y and X is a girl
    mother(X,Y) :- parent(X,Y), female_rule(X);

    % X is the mother of Y if X is the mother of Y
    mother_declaration(X,Y);

    mother(X,Y) :- parent_declaration(X,Y), father(Z,Y).

% father rules

    % X is the mother of Y if X is the parent of Y and X is a girl
    father(X,Y) :- parent(X,Y), male_rule(X);

    % X is the mother of Y if X is the mother of Y
    father_declaration(X,Y);

    father(X,Y) :- parent_declaration(X,Y), mother(Z,Y).

% child rules

    % X is a child of Y if Y is their parent
    child(X,Y) :- parent(Y,X).

% son rules

    % X is a son of Y if X is a child of Y and X is a guy
    son(X,Y) :- child(X,Y) , male_rule(X);

    % X is a son of Y if X is a son of Y
    son_declaration(X,Y).

% daughter rules

    % X is a son of Y if X is a child of Y and X is a guy
    daughter(X,Y) :- child(X,Y) , female_rule(X);

    % X is a daughter of Y if X is a daughter of Y
    daughter_declaration(X,Y).

% uncle rules

    % X is an uncle of Y if X is an uncle of Y
    uncle(X,Y) :- uncle_declaration(X,Y);

    % X is an uncle of Y if A is the parent of Y, and X is a brother of A
    parent(A,Y), brother(X,A).

% aunt rules

    % X is an aunt of Y if X is an aunt of Y
    aunt(X,Y) :- aunt_declaration(X,Y);

    % X is an aunt of Y if A is the parent of Y, and Y is a sister of A
    parent(A,Y), sister(X,A).

% relative rules
    relatives(X,Y):-
    % X and Y are relatives if they are siblings
    siblings(X,Y);
    siblings(Y,X);

    % X and Y are relatives if X is the parent of Y
    parent(X,Y);
    parent(Y,X);

    % X and Y are relatives if X is the grandparent of Y
    grandparent(X,Y);
    grandparent(Y,X);

    % X and Y are relatives if X is the child of Y
    child(X,Y);
    child(Y,X);

    % X and Y are relatives if X is the uncle of Y
    uncle(X,Y);
    uncle(Y,X);

    % X and Y are relatives if X is the uncle of Y
    aunt(X,Y);
    aunt(Y,X);

    % X and Y are relatives if Z is the aunt of X, and Z is the parent of Y
    aunt(Z,X),
    child(Y,Z);

    % X and Y are relatives if Z is the uncle of X, and Y is the child of Z
    uncle(Z,X),
    child(Y,Z).

% S rules
    brothers(X,Y) :- brother(X,Y).
    sons(X,Y) :- son(X,Y).
    daughters(X,Y) :- daughter(X,Y).
    parents(X,Y) :- parent(X,Y).
    sisters(X,Y) :- sister(X,Y).
    children(X,Y) :- child(X,Y).


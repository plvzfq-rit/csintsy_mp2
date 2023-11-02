
    sister_declaration(jennie,leslie).
    sibling_declaration(lola, bob).
    male_rule(bob).
    female_rule(lola).
    female_rule(a).
    male_rule(b).
    parent_declaration(X,Y).
    parent_declaration(lola, a).
    parent_declaration(lola, b).

    brother_declaration(X,Y).



    father_declaration(rod, kane).
    mother_declaration(kane, doug).



% sibling rules

    % X and Y are siblings if they share a parent
    siblings(X,Y) :- parent_declaration(Z,X), parent_declaration(Z,Y), X \= Y;

    % siblings are commutative and, X and Y are not the same person
    sibling_declaration(Y,X) , X \= Y;

    % X and Y are siblings if X is the sister of Y, and X and Y are not the same person
    sister_declaration(X,Y) , X \= Y;

    % X and Y are siblings if Y is the sister of X and, X and Y are not the same person
    sister_declaration(Y,X) , X \= Y;

    % X and Y are siblings if X is the brother of Y and, X and Y are not the same person
    brother_declaration(X,Y) , X \= Y;

    % X and Y are siblings if Y is the sister of X and, X and Y are not the same person
    brother_declaration(Y,X) , X \= Y.


% sister rules

    % X is the sister of Y if X and Y are siblings, X is a girl, and X and Y are not the same person
    sister(X,Y) :- sister_declaration(X,Y);
                   siblings(X,Y), female_rule(X), X \= Y.



% brother rules

    % X is the brother of Y if X and Y are siblings, X is a boy, and X and Y are not the same person
    brother(X,Y) :- brother_declaration(X,Y);
                    sibling_declaration(X,Y), male_rule(X), X \= Y.

% parent rules

    % X is the parent of Y if X is the father of Y
    parent_declaration(X,Y) :- father_declaration(X,Y).

    % X is the parent of Y if X is the mother of Y
    parent_declaration(X,Y) :- mother_declaration(X,Y).

    % X is the parent of Y if X is the mother of Y
    parent(X,Y) :- mother_declaration(X,Y).

    % X is the parent of Y if X is the father of Y
    parent(X,Y) :- father_declaration(X,Y).

    % X is the parent of Y if Y is the child of X
    parent(X,Y):- child_declaration(Y,X).

    % X is the parent of Y, if Y is the grandchild of Z and X is the child of Z
    parent(X,Y) :- grandparent(Z,Y), child(X,Z)


% grandparent rules

    grandparent(X,Y) :- parent_declaration(X,Z), parent_declaration(Z,Y).


%child rules
    % X is a child of Y if X is a child of Y
    child(X,Y) :- child_declarationn(X,Y);
    
    % X is a child of Y if X is their parent
    parent_declaration(X,Y);

    % X is a child of Y if X and Z are siblings and Y is the parent of Z
    siblings(X,Z), parent_declaration(Y,Z).
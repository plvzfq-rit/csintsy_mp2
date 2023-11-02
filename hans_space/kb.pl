%Testers
father_declaration(fill,fill).
mother_declaration(fill,fill).
brother_declaration(fill,fill).

    %Testing siblings
        %1
        parent_declaration(a,b).
        parent_declaration(a,c).
        % siblings(b,c).

        %2
        sibling_declaration(d,e).
        % siblings(e,d).

        %3 and 4
        sister_declaration(f,g).
        % siblings(f,g)
        % siblings(g,f)

        %5 and 6
        brother_declaration(h,i).
        %siblings(h,i)
        %siblings(i,h)


% sibling rules

    % 1. X and Y are siblings if they share a parent
    siblings(X,Y) :- parent_declaration(Z,X), parent_declaration(Z,Y), X \= Y;

    % 2. siblings are commutative and, X and Y are not the same person
   (sibling_declaration(Y,X) , X \= Y);

    % 3. X and Y are siblings if X is the sister of Y, and X and Y are not the same person
    (   sister_declaration(X,Y) , X \= Y);

    % 4. X and Y are siblings if Y is the sister of X and, X and Y are not the same person
    (   sister_declaration(Y,X) , X \= Y);

    % 5. X and Y are siblings if X is the brother of Y and, X and Y are not the same person
    (   brother_declaration(X,Y) , X \= Y);

    % 6. X and Y are siblings if Y is the sister of X and, X and Y are not the same person
    (   brother_declaration(Y,X) , X \= Y).


% sister rules

    % X is the sister of Y if X and Y are siblings, X is a girl, and X and Y are not the same person
    sister(X,Y) :- sister_declaration(X,Y);
                   siblings(X,Y), female_rule(X), X \= Y.



% brother rules

    % X is the brother of Y if X and Y are siblings, X is a boy, and X and Y are not the same person
    brother(X,Y) :- brother_declaration(X,Y);
                    sibling_declaration(X,Y), male_rule(X), X \= Y.

% parent rules

    % X is the parent of Y if X is the mother of Y
    parent(X,Y) :- parent_declaration(X,Y).

    % X is the parent of Y if X is the mother of Y
    parent(X,Y) :- mother_declaration(X,Y).

    % X is the parent of Y if X is the father of Y
    parent(X,Y) :- father_declaration(X,Y).

    % X is the parent of Y if Y is the child of X
    parent(X,Y):- child_declaration(Y,X).

    %implement grandparent rules

% grandparent rules

    grandparent(X,Y) :- parent(X,Z), parent(Z,Y).


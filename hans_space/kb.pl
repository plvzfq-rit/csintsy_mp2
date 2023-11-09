%Testers
father_declaration(fill,fill).
mother_declaration(fill,fill).
brother_declaration(fill,fill).
aunt_declaration(fill,fill).
son_declaration(fill,fill).
uncle_declaration(fill,fill).
grandfather_declaration(lm,no).
grandmother_declaration(pq,rs).
sibling_declaration(aee,brolan).
sibling_declaration(aee,crolan).
sibling_declaration(aee,dooloo).
sibling_declaration(aee,euloo).
male_rule(brolan).
male_rule(crolan).
female_rule(dooloo).
female_rule(euloo).
child_declaration(aaaa,lol).
child_declaration(aaab,lol).
child_declaration(aaac,lol).
child_declaration(aaad,lol).
son_declaration(ggg,sdfa).
son_declaration(hh,sdfa).
son_declaration(oos,sdfa).
daughter_declaration(dsa,sdfa).
daughter_declaration(da,sdfa).
daughter_declaration(ds,sdfa).
    sister_declaration(x,y).
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
        % siblings(f,g).
        % siblings(g,f).

        %5 and 6
        brother_declaration(h,i).
        %siblings(h,i).
        %siblings(i,h).

    %Testing Sister
        %1
        %sister(f,g).

        %2
        female_rule(b).
        %sister_declaration(b,c).

     %Testing Brother
        %1
        % brother(h,i).

        %2
        male_rule(d).
        %brother(d,e)

     %Testing parents
        %1
        parent_declaration(j,k).
        parent_declaration(asd,k).
        %parent(j,k).

        %2
        mother_declaration(l,m).
        %parent(l,m).

        %3
        father_declaration(n,o).
        mother_declaration(qqq,o).
        %parent(n,o).

        %4
        child_declaration(p,q).
        %parent(q,p).

     %Testing grandparents
        %1
        father_declaration(k,r).
        % grandparent(j,r).
        grandfather(aaaa,aaab).

    % Testing mother
        %1
        mother_declaration(u,v).
        % mother(u,v).

        %2
        female_rule(j).
        % mother(j,k).

    % Testing father
        %1
        % father(n,o).

        %2
        parent_declaration(w,x).
        male_rule(w).
        % father(w,x).

    % Testing child
        %1
        % child(k,j)

        %2
        % child(m,l)

        %3
        % child(o,n)

        %4
        % child(p,q)

    % Testing Son
        %1
        parent_declaration(y,z).
        male_rule(z).
        % son(z,y)

        %2
        son_declaration(aa,ab).
        %2 son(aa,ab).

    % Testing daughter
        %1
        parent(ac,ad).
        female_rule(ad).
        % daughter(ad,ac).

        %2
        daughter_declaration(ae,af).
        %daughter(ae,af).

    % Testing uncle
        %1
        uncle_declaration(ag, ah).
        % uncle(ag,ah).

        %2
        parent_declaration(ai,aj).
        brother_declaration(ak,ai).
        % uncle(ak,aj).

    % Testing aunt
        %1
        aunt_declaration(al, am).
        % aunt(al,am).

        %2
        parent_declaration(an,ao).
        sister_declaration(ap,an).
        % aunt(ap,ao).

    % Testing Relatives
        %1
        % relatives(h,i).

        %2
        % relatives(j,k).

        %3
        % relatives(j,r).

        %4
        % relatives(k,j).

        %5
        % relatives(ag,ah).

        %6
        % relatives(al,am)

        %7
        aunt_declaration(aaa, bbb).
        child_declaration(ccc, aaa).
        % relatives(aaa, bbb). (commutative)

        %8
        aunt_declaration(ddd, eee).
        child_declaration(fff, eee).
        % relatives(fff, eee). (commutative)






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
    mother_declaration(X,Y).

% father rules

    % X is the mother of Y if X is the parent of Y and X is a girl
    father(X,Y) :- parent(X,Y), male_rule(X);

    % X is the mother of Y if X is the mother of Y
    father_declaration(X,Y).

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


% relr(a,b).
% relr(b,c).
% relr(c,d).
% relr(c,e).
% relr(e,f).
% relr(f,g).
% relr(f,h).

% rel(A,B) :- relr(A,B).
% rel(A,B) :- relr(B,A).
% %rel(B,A) :- relr(A,B).
% %rel(B,A) :- relr(B,A).
% rel(A,B) :- relr(A,C), rel(C,B).
% rel(A,B) :- relr(C,B), rel(A,C).
% rel(B,A) :- relr(A,C), rel(C,B).
% rel(B,A) :- relr(C,B), rel(A,C).

% sibd(a,b).
% sib(X,Y) :- sibd(X,Y).
% sib(Y,X) :- sibd(X,Y).
% not_mother(X,Y) :- sib(X,Y).

parent_declaration(a,b).
has_two_parents(X) :- parent(Y,X), parent(Z,X), \+ Y == Z.
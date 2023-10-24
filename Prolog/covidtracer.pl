
/* data */
met(john,28,mary).
met(john,3,mary).
met(peter,21,john).
met(mary,23,mark).
met(anne,19,peter).
met(anne,29,john).
met(anne,24,mary).
met(mark,17,paul).

/* my helper predicates */
myreverse([X],[X]).
myreverse([H|T],L) :- myreverse(T,R), myappend(R,[H],L).
mymember(X,[X|_]).
mymember(X,[_|Xs]) :- mymember(X,Xs).
myappend([],L,L). 
myappend([H|T1],Y,[H|T2]) :- myappend(T1,Y,T2).

/* contact
Finds the path from a start person to a goal person, tracking infections
through meetings.
Calls trace and appends the start person to the path, then reverses it */
contact(infect(SP,SD), infect(GP,GD), P) :- trace(infect(SP,SD), infect(GP,GD), P2, [SP]), myappend(P2, [infect(SP,SD)], P3), myreverse(P3, P).

/* trace
Traces the path from a current person to a goal person, using meetings and infection times */
/* base case: if the current person is the goal person and the timing works, the path is empty */
trace(infect(CP, CD), infect(CP, GD), [], _) :- (CD - GD) =< 7, (GD - CD) =< 7, GD > CD.
/* recursive case: the current person is not the goal person */
trace(infect(CP, CD), infect(GP, GD), P, V) :- 
                /* find a middle person that the current person has met */
                (met(CP, MD, MP); met(MP, MD, CP)),
                /* the timing must be within 7 days (absolute value) */
                (MD - CD) =< 7, (CD - MD) =< 7,
                /* check that we haven't visited this middle person yet */
                \+ mymember(MP, V),
                /* append the middle person to the visited list */
                myappend(V,[MP],V1),
                /* recursively trace the rest of the path if possible */
                trace(infect(MP, MD), infect(GP, GD), P1, V1),
                /* find the path by appending to a successful traced path */
                myappend(P1,[infect(MP, MD)],P).

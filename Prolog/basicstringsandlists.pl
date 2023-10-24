

%myappend:
/*
Appends a list to another list, with the final argument containing the appended list
*/
/*base case: if the first list is empty, the appended lists is the second list*/
myappend([],L,L). 
/*recursive case: iterate through the first list, ensuring the first elements of
the first list and the result list are the same*/
myappend([H|T1],Y,[H|T2]) :- myappend(T1,Y,T2).

%myreverse:
/*
The second list is an exact copy of the first list, but in reverse. 
*/
/*base case: a single-element list is the same forward and backward*/
myreverse([X],[X]).
/*recursive case: iterate through the first list, appending each
element in order to the back of the second list.*/
myreverse([H|T],L) :- myreverse(T,R), myappend(R,[H],L).

%myflatten:
/*
The first list is a list of lists, and the second list is a single list
containing just the elements within the first lists.
*/
/*base case: an empty list flattens to an empty list*/
myflatten([],[]).
/*recursive case: flatten the first element of the first list, and recurse on the
rest of the list. Then append all the flattened lists together into one list.*/
myflatten([H|T],L) :- myflatten(H,R1), myflatten(T,R2), myappend(R1,R2,L).
/*another base case: any single value flattens to a list containing that value*/
myflatten(X,[X]).

%mymember:
/*
Checks if the first value exists in the second list.
*/
/*base case: if the head of the list matches the value given, it is a member
of the list.*/
mymember(X,[X|_]).
/*recursive case: iterate through the list if the first element doesn't match.*/
mymember(X,[_|Xs]) :- mymember(X,Xs).

%myremove:
/*
The last list is an exact copy of the first list, but removing one occurrence
of the first value given.
*/
/*base case: If the fist element in the first list matches the given value, the
solution is simply the rest of the list.*/
myremove(X,[X|T],T).
/*recursive case: iterate through the two lists when their elements don't match
the value given.*/
myremove(X,[H|T1],[H|T2]) :- myremove(X,T1,T2).

/*
myremove(X,[H|T],Z) :- myremove(X,T,R), myappend([H],R,Z).
*/


%mymember2:
/*
Determines if the first value is found exactly twice in the second list.
A value is a member twice if it is a member of the given list, and a member of 
the list with one occurence of the value removed, but not a member of the list with
both occurrences removed.
*/
mymember2(X,L) :- mymember(X,L), myremove(X,L,L2), mymember(X,L2), myremove(X,L2,L3), \+ mymember(X,L3).



%mysubstring:
/*
Evaluates whether a list is a contiguous sublist of another list.
*/
/*trivial case: an empty list is a substring of anything.*/
mysubstring([],_).
/*nontrivial case: a list is a substring if you can append something 
on either side to give you the big list.*/
mysubstring(S,L) :- myappend(_,T,L), myappend(S,_,T).


%mysublists:
/*
The second element in mysublists is a list containing all, not necessarily
contiguous, sublists of the first list. This predicate uses a helper predicate, isSublist.
*/
/*base case: an empty list is a sublist of any list.*/
isSublist([],_).
/*recursive case: if the first elements of the lists both match, recurse on their tails.*/
isSublist([H|T1],[H|T2]) :- isSublist(T1,T2).
/*recursive case: if the first elements don't match, keep iterating through the second list.*/
isSublist(X,[_|T]) :- X = [_|_], isSublist(X,T).

/*Find all the sublists using the findall and isSublist predicates.*/
mysublists(S,L) :- findall(X,isSublist(X,S),L).



%mypermutation:
/*
The second list is a permutation of the first list.
*/
/*base case: the only permutation of an empty list is an empty list.*/
mypermutation([],[]).
/*recursive case: remove the head from the list and recurse on it and the tail.*/
mypermutation([H|T],L) :- mypermutation(T,L2), myremove(H,L,L2).



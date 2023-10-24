
/* max_list
Finds the max value in a list using recursion
 */
 /* base case: the max value of an empty list is 0 (lowest case) */
max_list([],0).
/* recursive cases: if the next element is larger than the current
max, set it to the  max and continue recursing */
max_list([H|T],M) :- max_list(T,M2), H > M2, M is H.
/* recursive case: if the next element is not the largest,
keep recursing */
max_list([H|T],M) :- max_list(T,M2), H =< M2, M is M2.


/* nth_element
Finds the nth element of a given list (like indexing)
 */
 /* base case: if N is 0, the nth element is the head of the list */
nth_element([H|_],0,H).
/* recursive case: if N is not 0 yet, keep recursing through the list */
nth_element([_|T], N, V) :- N > 0, N2 is N-1, nth_element(T, N2, V2), V is V2.

/* sqrt
Computes the square root of a number using Newton's method
 */
/* helper predicate: executes N iterations of Newton's method
base case: when you've reached a counter of 0, keep the square root
you've calculated already */
sqrtCounter(_, X, X, 0).
/* recursive case: compute a new guess and recurse */
sqrtCounter(N, X, Guess, Counter) :- 
                C2 is Counter - 1, 
                X2 is 0.5 * (Guess + N/Guess),
                sqrtCounter(N, X, X2, C2).

/* Calculate the square root by using the helper predicate */
sqrt(N, X) :- sqrtCounter(N, X, N, N).

/* Example BST
            5
           /\
          3   9
         /\    /\
        1  4  7  12
*/
node(5, node(3, node(1, nil, nil), node(4, nil, nil)), node(9, node(7, nil, nil), node(12, nil, nil))).
node(5, node(7, node(1, nil, nil), nil), node(9, nil, node(12, nil, nil))).

/* Example non-BST
            5
           /\
          2   9
         /\    /\
        4  3  7  8
*/
node(5, node(2, node(4, nil, nil), node(3, nil, nil)), node(9, node(7, nil, nil), node(8, nil, nil))).

/* helper predicates
find the max value in a binary search tree */
max_bst(node(X, nil, nil), X).
max_bst(node(_, _, RN), X) :- max_bst(RN,X1), X is X1.
/* find the min value in a binary search tree */
min_bst(node(X, nil, nil), X).
min_bst(node(_, LN, _), X) :- min_bst(LN, X1), X is X1.

/* binary_search_tree
Checks if a given structure is a binary search tree */
binary_search_tree(node(K, LN, RN)) :- 
                /* check that the left tree is either nil or a valid bst */
                ((LN = node(LK, _, _), LK < K, binary_search_tree(LN), max_bst(LN, X1), X1 < K); LN = nil),
                /* check that the right tree is either nil or a valid bst */
                ((RN = node(RK, _, _), RK > K, binary_search_tree(RN), min_bst(RN, X2), X2 > K); RN = nil).

/* binary_search
Evaluates if a given value exists in a given binary search tree
base case: if the value at the node is the same as the value we're searching for, it's true */
binary_search(node(K, _, _), K) :- !.
/* recursive case: if the searched value is less than the value at the node, search to the left */
binary_search(node(K, LN, _), V) :- V < K, binary_search(LN, V), !.
/* recursive case: if the searched value is greater than the value at the node, search to the right */
binary_search(node(K, _, RN), V) :- V > K, binary_search(RN, V), !.

%Q5:
/* given code */
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



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


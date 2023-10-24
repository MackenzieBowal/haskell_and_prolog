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

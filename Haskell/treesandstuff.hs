
-- 1
data Expr = Lit Integer
    | Add Expr Expr
    | Sub Expr Expr

-- size()
-- Takes an expression and returns the number of operators (Add/Subtract) in
-- the expression
size :: Expr -> Int
size (Lit n) = 0    -- base case: a literal is not an operator and returns 0
size (Add exp1 exp2) = 1 + size exp1 + size exp2    -- For an Add operator, add 1 and recurse
size (Sub exp1 exp2) = 1 + size exp1 + size exp2    -- For a Sub operator, add 1 and recurse

-- Example expression to test size function
myExp :: Expr
myExp = Sub (Add (Lit 5) (Sub (Lit 8) (Lit 2))) (Lit (-7))      -- (5 + (8-2)) - (-7)

-- 2
data NTree = NilT | Node Int NTree NTree

-- collapse()
-- Takes an NTree and returns the values at the nodes from left
-- to right stored in a list
collapse :: NTree -> [Int]
collapse NilT = []      -- Base case: at a leaf, return the emtpy list
collapse (Node x left right) = collapse left ++ [x] ++ collapse right   -- recursive case: at
                                                    -- an internal node, concatenate the value with the
                                                    -- collapsed lists of the left and right subtrees

-- Example NTree to demonstrate collapse function
{-
                1
               / \
              3   5
             / \   \
            2   -4   7
           /
          5
-}
myNTree :: NTree
myNTree = Node 1 (Node 3 (Node 2 (Node 5 NilT NilT) NilT) (Node (-4) NilT NilT)) (Node 5 NilT (Node 7 NilT NilT))


-- 3
data GTree a = Leaf a | Gnode [GTree a]

-- Example GTree for testing the functions:
{-
        /      |     \ 
       /\     /|\    'a'
    'b' 'c' 'd'| 'e'
              'f' 
-}
myGTree :: GTree Char
myGTree = Gnode [Gnode [Leaf 'b', Leaf 'c'], Gnode [Leaf 'd', Gnode [Leaf 'f'], Leaf 'e'], Leaf 'a'] 

-- numberOfLeaves()
-- Takes a GTree and returns the number of leaves in the tree
numberOfLeaves :: GTree a -> Int
numberOfLeaves (Leaf x) = 1     -- Base case: For a leaf, return 1
numberOfLeaves (Gnode []) = 0   -- Base case: for a Gnode with no subtrees, return 0
numberOfLeaves (Gnode (x:xs)) = numberOfLeaves x + numberOfLeaves (Gnode xs)    -- Recursive case: for a
                                -- Gnode with children, find the number of leaves for its first child and
                                -- recurse on the rest

-- depth()
-- Takes a GTree and returns the depth of the tree.
-- ** I assume the depth is the number of edges in the tree when drawn out **
depth:: GTree a -> Int
depth (Leaf x) = 0      -- base case: a leaf has a depth of 0
depth (Gnode []) = 0    -- base case: an empty Gnode has a depth of 0
depth (Gnode (x:xs)) = max (1 + depth x) (depth (Gnode xs))     -- recursive case: a non-empty Gnode
                                -- as depth equal to the max of its subtrees, including its own edge.

-- findVal()
-- Takes a value and a GTree and returns True if the value exists in the tree, False otherwise
findVal :: Eq a => a -> GTree a -> Bool
findVal v (Leaf x) = (v == x)   -- Base case: if a leaf, compare the values directly
findVal v (Gnode []) = False    -- Base case: if an empty Gnode, return False
findVal v (Gnode (x:xs)) = (findVal v x) || (findVal v (Gnode xs))  -- Recursive case: If a non-empty 
                                -- Gnode, check the first subtree and "or" it with a recursion on the
                                -- rest of the subtrees


-- 4
-- Defining type Vector as a list of Ints
type Vector = [Int]

-- scalarProduct()
-- Takes two vectors and returns their scalar product
scalarProduct :: Vector -> Vector -> Int
scalarProduct xs ys = sum (zipWith (*) xs ys)   -- Use zipWith to multiply
                        -- corresponding elements, then use sum to add them together



-- 5
-- factorial
-- A list of Ints containing the values [1!, 2!, 3!, ...]
factorial :: [Int]
factorial = [fact x | x <- [1 .. ]]     -- List comprehension on an infinite list, mapping fact
    where
        fact 0 = 1      -- base case: Factorial of 0 = 1
        fact x = x * fact (x-1) -- recursive case: x times the factorial of x-1




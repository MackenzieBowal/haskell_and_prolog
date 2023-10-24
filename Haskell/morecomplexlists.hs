

-- iter
-- Takes an Int n, a function, and an input for the function and 
-- returns the value of the function applied to the input n times
iter :: Int -> (a -> a) -> a -> a
iter 0 _ x = x                          -- Base case: return x if n is 0
iter n f x = f (iter (n-1) f x)         -- Recursive case: return f applied to a recursive
                                        -- call on n - 1, f, and x

-- opSec
-- Example function to show that the operator sections work
opSec :: [Int] -> [Int]
opSec lst = (map (+ 1) . filter (>=  0)) lst    -- First filters for non-negative integers, then adds 1 with mapping

-- foldIter
-- Takes an Int n, a function, and an input value
-- for the function, and applies the function to the input n times.
foldIter :: Int -> (a -> a) -> a -> a
foldIter n f x = (foldl (.) f (map (\_ -> f) [1 .. n-1])) x     -- fold f to itself n times, then apply
                                                                -- the resulting function to the input

-- 4
curry3' :: ((a, b, c) -> d) -> (a -> b -> c -> d)
curry3' f = \a b c -> f (a, b, c)


-- curry3
-- Takes a function as an input, which itself takes a 3-value tuple as input.
-- Returns a function which is equivalent, but in curried form
curry3 :: ((a, b, c) -> d) -> (a -> b -> c -> d)
curry3 f = \a -> curry (\(b, c) -> f (a, b, c))     -- Take in a as a parameter, then curry a
                                                    -- function which takes in b and c as uncurried
                                                    -- arguments, and applies f to all three

-- fC3
-- An example 3-input uncurried function to test curry3
fC3 :: (Int, Int, Int) -> Int
fC3 (x, y, z) = x + y - z       -- performs a simple operation on 3 integers

-- uncurry3
-- Takes a function as an input, which itself is a curried 3-input function.
-- Returns a function which is equivalent, but in uncurried form
uncurry3 :: (a -> b -> c -> d) -> ((a, b, c) -> d)
uncurry3 f = \(a, b, c) -> uncurry f (a, b) c       -- Take in a 3-tuple as a paramenter, then
                                                    -- uncurry a function which takes a 2-tuple (pair)
                                                    -- and a singleton input

-- fUC3
-- An example 3-input curried function to test uncurry3
fUC3 :: Int -> Int -> Int -> Int
fUC3 x y z = x + y - z          -- performs a simple operation on 3 integers

-- 5
curryList' :: ([a] -> d) -> (a -> [a] -> d)
curryList' f = \a lst -> f (a:lst)


-- curryList
-- Takes a function as an input, which itself takes a list as input.
-- Returns a function which is equivalent, but in curried form with the
-- first element of the list as a separate input from the rest of the list.
curryList :: ([a] -> d) -> (a -> [a] -> d)
curryList f = curry (\(a, lst) -> f (a:lst))    -- Curry a function which takes a
                                                -- value and a list as input, and executes
                                                -- f on the full list with the value appended
                                                -- to the head

-- fCList
-- An example input to test curryList, which takes a list as input
fCList :: [Int] -> Int
fCList lst = foldl (+) 0 lst        -- performs a simple summation of the elements in the list


-- uncurryList
-- Takes a function as an input, which itself takes a value and a list as input.
-- Returns a function which is equivalent, but in uncurried form with the
-- first element of the list appended to the rest of the list.
uncurryList :: (a -> [a] -> d) -> ([a] -> d)
uncurryList f = \lst -> uncurry f (head lst, tail lst)    -- Take a list as input, then uncurry
                                                          -- a function which takes the first
                                                          -- element and the rest as inputs
                                                        
-- fUCList
-- An example input to test uncurryList, which takes an Int and a list as inputs
fUCList :: Int -> [Int] -> Int
fUCList a lst = a - foldl (+) 0 lst   -- subtracts the summation of the list from
                                      -- the singleton input


{-
-- CURRY

f :: a -> b -> c -> d             --  curried

f :: (a, b, c) -> d           --    uncurried
f :: (a, b) -> (c -> d)   partially curried
f :: a -> (b -> (c -> d))           curried



f :: (a, b, c) -> d               uncurried
f :: a -> ((b, c) -> d)
f :: a -> (b -> (c -> d))           curried

f :: ((a, b), c) -> d               uncurried

curry3 :: ((a, b, c) -> d) -> (a -> b -> c -> d)
curry3 f = \a -> curry(\(b, c) -> d)

curry :: ((e, f) -> g) -> (e -> f -> g)
    --f :: a -> ((b, c) -> d)
    --f :: (a, b) -> (c -> d)   partially curried
-}


{-
--- UNCURRY

f :: a -> (b -> (c -> d))           curried
f :: (a, b) -> (c -> d)   partially curried
f :: (a, b, c) -> d               uncurried


f :: a -> (b -> (c -> d))           curried
f :: a -> ((b, c) -> d)
f :: (a, b, c) -> d               uncurried

uncurry :: (e -> f -> g) -> ((e, f) -> g) 

uncurry3 :: (a -> b -> c -> d) -> ((a, b, c) -> d) 
uncurry3 f = uncurry(a, (b, c), f(a, b, c))
--uncurry3 f = uncurry(

-}
import Text.XHtml (base, caption, name)
import Distribution.SPDX
import Distribution.Simple.Utils (xargs)
import GHC.Base (VecElem(Int16ElemRep))


or :: Bool -> Bool -> Bool
or a b = a || b

-- Int and Integer
-- Int is bounded, Integer is not

five :: Int
five = 5

add :: Int -> Int -> Int
add a b = a + b

add' a b = (+) a b

addThree :: Int -> Int -> Int -> Int
addThree a b c = a `add` b `add` c          -- Infix and prefix are different syntax for the same thing

-- Divide floats:
floatNumber :: Float
floatNumber = 5.7

divideFloats :: Float -> Float -> Float
divideFloats a b = a / b 

divideFloats' a b = (/) a b 

addFloatInt :: Int -> Float -> Int
addFloatInt a b = a + floor b       -- Instead of "floor", can also use "round"


absolute :: Int -> Int
absolute a = abs a

s = absolute (-9)       -- Passing a negative number into a function always needs ()

s' = absolute 7 - 8      -- will compute (absolute 7) - 8
s'' = absolute (7-8)      -- will compute it properly


-- Char type
a :: Char
a = 'a'

b :: Char
b = 'b'

chartoInt :: Char -> Int    -- Can convert Char to Int to get ASCII
chartoInt c = fromEnum c

-- String = [Char]
hello :: [Char]
hello = "hello"

helloWorld :: [Char]
helloWorld = hello ++ " world"


-- Local variables

sumSquares :: Int -> Int -> Int
sumSquares n m = sqN + sqM
    where sqN = n * n                           -- or "let" instead of "where"
          sqM = m * m
          square x = x * x                      -- Or even do this, and call square in sumSquares

          -- Note: order?


sumSquares' :: Int -> Int -> Int
sumSquares' n m =
    let                     -- Here we define some local definitions
    sqN = n * n
    sqM = m * m
    in sqN + sqM            -- Main body of your bigger function


mystery :: Int -> Int -> Int -> Bool
mystery m n p = not ((m == n) && (n == p))

-- These might be min rather than max oh well

maxTwo :: Int -> Int -> Int
maxTwo x y = if x >= y then y else x

maxTwo' :: Int -> Int -> Int
maxTwo' x y | x >= y    = x
            | otherwise = y

maxTwo_ :: Int -> Int -> Int
maxTwo_ x y = case x >= y of
    True -> x
    False -> y

myOr :: Bool -> Bool -> Bool
myOr x y = case x of
    True -> True
    False -> case y of
        True -> True
        False -> False

myOr' :: Bool -> Bool -> Bool
myOr' False False = False
myOr' _ _ = True

-- Nand

myNand :: Bool -> Bool -> Bool
myNand True True = False
myNand _ _ = True

-- More examples

between :: Int -> Int -> Int -> Bool
between x y z = ((x >= y) && (y >= z)) || ((x <= y) && (y <= z))

middleNumber :: Int -> Int -> Int -> Int
middleNumber x y z 
    | between x y z = y
    | between y x z = x
    | otherwise = z


average :: Int -> Int -> Int -> Float
average x y z = fromIntegral (x + y + z) / 3.0

numAboveAvg :: Int -> Int -> Int -> Int
numAboveAvg x y z = (check x) + (check y) + (check z) where
    check :: Int -> Int
    check a = if fromIntegral a > (average x y z) then 1 else 0


-- How many of the args are the max?
maxThree :: Int -> Int -> Int -> Int
maxThree x y z
    | x >= y && x >= z = x
    | y >= z           = y
    | otherwise        = z

maxThree' :: Int -> Int -> Int -> Int
maxThree' x y z = (x `maxTwo` y) `maxTwo` z     -- clever!

maxThreeOccurs :: Int -> Int -> Int -> Int
maxThreeOccurs x y z = (isMax x) + (isMax y) + (isMax z) where
    isMax :: Int -> Int
    isMax a = if a == maxThree x y z then 1 else 0




myAdd :: Int -> Int -> Int
myAdd n m 
    | n < 0     = error "input should be a natural number"
    | n == 0     = m
    | otherwise = ((myAdd (n-1)) m) + 1

myMult :: Int -> Int -> Int
myMult n m
    | n < 0     = error "input should be a natural number"
    | n == 1    = m
    | otherwise = myAdd (myMult (n - 1) m) m

-- Factorial
myFact :: Int -> Int
myFact n 
    | n < 0     = error "invalid"
    | n == 0    = 1
    | otherwise = n * myFact (n-1)


l1 :: [Int]
l1 = [1, 2, 3]

l2 :: [[Int]]
l2 = [[1, 2], [3, 4]]

l3 :: [(Int, Char, Float)]
l3 = [(1, '1', 1.0), (2, '2', 2.0)]

l6 :: [Integer]
l6 = 1 : [] -- [1]

l7 :: [Integer]
l7 = 2 : l6   -- [2, 1]

--Texas ranges (another way of defining a list)
-- [ n .. m] ==> [n, n+1, n+2, ... ,m] (if m < n ==> [])
    -- Doesn't have to be integers, just anything that can be ordered
l8 :: [Integer]
l8 = [1 .. 5]

-- [n, p, .. m] ==> [n, n + (p-n), n + 2(p-n), ... ,m]
l9 :: [Float]
l9 = [2.0, 2.5 .. 4.4]

-------

l = length l8
h = head l8
t = tail l8

-- [] and (a:as) used as pattern mattching for lists (empty list and non-empty list)

myProduct :: [Int] -> Int
myProduct lst
    | length lst == 0   = 1
    | otherwise         = head lst * myProduct (tail lst)

myProduct' :: [Int] -> Int
myProduct' [] = 1
myProduct' (a:as) = a * myProduct' as

mySum :: [Int] -> Int
mySum [] = 0
mySum lst = head lst + mySum (tail lst)
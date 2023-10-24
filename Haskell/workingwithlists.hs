import Distribution.Simple.Utils (maybeExit)
import Data.Char
import Text.XHtml (base)


subLists :: [a] -> [[a]]

subLists [] = [[]]
subLists (x:xs) = [x:x' | x' <- (subLists xs)] ++ (subLists xs)

subSequences :: (Enum a, Eq a) => [a] -> [[a]]
subSequences [] = [[]]
subSequences (x:xs) = [x:x' | x' <- (subLists xs), isSubSequence (x:x')] ++ subSequences xs
    where
        isSubSequence :: (Enum a, Eq a) => [a] -> Bool
        isSubSequence [] = True
        isSubSequence [x] = True
        isSubSequence (x:y:rs) = (succ x == y) && isSubSequence (y:rs)



-- Example of a higher order function is filter
-- Takes a predicate and a list
-- Selects the elements of the list where the predicate evaluates to True
-- Predicate is function of type a -> Bool

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter _ [] = []
myFilter p (x:xs)
    | p x       = x : myFilter p xs
    | otherwise = myFilter p xs

isSmall c = c <= 'z' && c >= 'a'

capitalizeLetters :: [Char] -> [Char]
capitalizeLetters str = map toUpper (filter isSmall str)


-- zipWith is a combination of zip and map
myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith f (x:xs) (y:ys)   = f x y : myZipWith f xs ys
maybeExit f _ _ = []

-- Rewrite grow function:
--grow = zipWith repeat str [1 .. length str]

-- Fold function (foldr and foldl in prelude)
myFoldr :: (a -> b -> b) -> b -> [a] -> b
myFoldr f x0 [] = x0
myFoldr f x0 (y:ys) = f y (myFoldr f x0 ys)

-- example uses:
mySum :: [Integer] -> Integer
mySum (x:xs) = myFoldr (+) x xs

sum' xs = myFoldr (+) 0 xs
product' xs = myFoldr (*) 1 xs
concat' xs = myFoldr (++) [] xs


map' :: (a -> b) -> [a] -> [b]
map' f xs = [f x | x <- xs]  -- most trivial way

map1 f [] = []
map1 f (x:xs) = (f x) : map1 f xs   -- recursive way

myFoldr' :: (a -> b -> b) -> b -> [a] -> b
myFoldr' f c [] = c    -- base case
myFoldr' f c (x:xs) = f x (myFoldr' f c xs)

myFoldl :: (b -> a -> b) -> b -> [a] -> b
myFoldl f c [] = c    -- base case
myFoldl f c (x:xs) = myFoldl f (f c x) xs

myConcat :: [[a]] -> [a]
myConcat lst = myFoldl (++) [] lst

isSorted :: [Integer] -> Bool
isSorted [] = True
isSorted [_] = True
isSorted (x:y:rs) = (x<=y) && isSorted (y:rs)
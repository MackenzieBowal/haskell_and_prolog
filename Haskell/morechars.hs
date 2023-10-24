isPrefixOf :: String -> String -> Bool
isPrefixOf "" _ = True
isPrefixOf _ "" = False
isPrefixOf (x:xs) (y:ys) = x == y && isPrefixOf xs ys


-- Need:
-- f :: [String] -> [String]
-- g :: [String] -> Int
-- g = length
countStringsStartWith :: String -> [String] -> Int
countStringsStartWith prefix = length . filter (\x -> prefix `isPrefixOf` x)

-- Capitalizes characters in a string
offset = fromEnum 'a' - fromEnum 'A'

toUpper :: Char -> Char
toUpper ch = toEnum (fromEnum ch - offset)

isLetter :: Char -> Bool
isLetter x = (x <= 'z' && x >= 'a') || (x <= 'Z' && x >= 'A')

capitalizeLetters :: [Char] -> [Char]
capitalizeLetters str = [toUpper ch | ch <- str, isLetter ch]

-- prelude zip function
-- use in function grow, which takes a string and returns a string where each character 
-- is repeated i times, where i is the index of that character in the original string
grow :: [Char] -> [Char]
grow str = helper (zip str [1 .. length str]) where
    helper [] = []
    helper ((x,y):xs) = myRepeat x y ++ helper xs

myRepeat :: Char -> Int -> [Char]
myRepeat _ 0 = ""
myRepeat ch i = [ch] ++ myRepeat ch (i-1)

-- prelude reverse function (define it myself)
myReverse :: [a] -> [a] --list of any type returns list of same type
myReverse [] = []
myReverse (x:xs) = myReverse xs ++ [x]

-- prelude elem function checks if a is element of [a]
myElem :: Eq a => a -> [a] -> Bool
myElem _ [] = False
myElem x (y:ys) = x == y || myElem x ys


filterNonUpperCase :: [Char] -> [Char]
filterNonUpperCase str = [x | x <- str, x `elem` ['A' .. 'Z']]


myReplicate :: Int -> a -> [a]
myReplicate 0 _ = []
myReplicate n a = [a] ++ myReplicate (n-1) a

starSquare :: Int -> String
starSquare n = concat [(myReplicate n '*') ++ "\n" | _ <- [1 .. n] ]

printStars :: String -> IO()
printStars stars = putStr(stars)

-- Types!

-- Shape is called a type constructor, Circle and Rectangle are called data/value constructors
data Shape = Circle Float | Rectangle Float Float

myCirc :: Shape
myCirc = Circle 3.5

-- "type" keyword defines a type alias (just gives a new name to an existing type)
type Radius = Float
type Height = Float
type Width = Float

data Shape' = Circle' Radius | Rectangle' Height Width    -- Makes it a little more readable

surfaceArea :: Shape -> Float
surfaceArea (Circle r) = pi * r ^ 2
surfaceArea (Rectangle h w) = h * w

-- Recursive data types
data MyList a = Empty | Cons a (MyList a)

mylst :: MyList Int
mylst = Cons 2 (Cons 1 Empty)       -- equivalent to 2 : 1 : []

data BTree a = Leaf a | BNode (BTree a) (BTree a)

myBTree :: BTree Char
myBTree = Leaf 'a'

myBTree' :: BTree Char
myBTree' = BNode (Leaf 'a') (Leaf 'b')

depth :: BTree a -> Int
depth (Leaf _) = 1
depth (BNode left right) = 1 + max (depth left) (depth right)

sumBTree :: BTree Int -> Int
sumBTree (Leaf x) = x
sumBTree (BNode left right) = sumBTree left + sumBTree right


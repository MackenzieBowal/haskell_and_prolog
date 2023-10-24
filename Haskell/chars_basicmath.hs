
mystery :: Int -> Int -> Int -> Bool
mystery m n p = not ((m == n) && (n == p))

-- minTwo takes two Ints and returns the one that is 
-- the smallest. If they are equal, it returns that number.
minTwo :: Int -> Int -> Int
minTwo a b
    | a <= b = a 
    | b < a = b

-- minThree takes three Ints and returns the one that is 
-- the smallest. If they are all equal, it returns that number.
minThree :: Int -> Int -> Int -> Int
minThree a b c
    | a <= b && a <= c  = a
    | b <= a && b <= c  = b
    | c <= a && c <= b  = c

-- charToNum takes a Char and returns it as an Int.
-- If the Char is between '0' and '9', it will return
-- the corresponding Int between 0 and 9. Otherwise,
-- it will throw an error.
charToNum :: Char -> Int
charToNum ch = if isDigit (num) then num            -- Return num if it is a single digit
                else error "Enter a digit" where    -- Throw an error if it is not a digit
    num = fromEnum ch - fromEnum '0'                -- Convert Char to corresponding Int
    isDigit :: Int -> Bool                          -- isDigit checks that an Int is between 0 and 9
    isDigit x
        | x >= 0 && x <= 9  = True
        | otherwise         = False

-- romanDigit takes a Char and converts it to the corresponding roman numeral as a String.
romanDigit :: Char -> String
romanDigit ch
    | n == 0    = ""                                -- No '0' in roman numerals. Also a base case
    | n <= 3    = "I" ++ romanDigit (toChar (n-1))  -- Recurse adding "I" for <=3
    | n == 4    = "IV"                              -- Define '4'
    | n <= 7    = if n == 5 then "V" else romanDigit (toChar (n-1)) ++ "I"  -- Define 5-7
    | n <= 9    = if n == 9 then "IX" else "I" ++ romanDigit (toChar (n+1)) -- Define 8-9
    where 
        n = charToNum (ch)              -- Use charToNum as defined in the last question
        toChar :: Int -> Char           -- Convert from an Int back to the Char value for recursion
        toChar m = toEnum (m + fromEnum '0')    -- Code for this line found here: 
                                -- https://stackoverflow.com/questions/20659810/haskell-int-to-char


-- smallerRoot and largerRoot return the larger and smaller roots of a
-- quadratic equation defined by three input floats.
smallerRoot, largerRoot :: Float -> Float -> Float -> Float
smallerRoot 0 _ _   = 0                     -- If the denominator (2a) is 0, return 0
smallerRoot a b c
    | descriminant < 0   = 0                -- If the descriminant is negative, return 0
    | otherwise          = numerator / denominator  -- Otherwise, compute the real root
    where
        numerator = -b - sqrt(descriminant)     -- Smaller root uses (-)
        denominator = 2 * a
        descriminant = (b * b - 4 * a * c)      -- Descriminant = b^2 - 4ac

largerRoot 0 _ _    = 0                     -- If the denominator (2a) is 0, return 0
largerRoot a b c
    | descriminant < 0   = 0                -- If the descriminant is negative, return 0
    | otherwise          = numerator / denominator  -- Otherwise, compute the real root
    where
        numerator = -b + sqrt(descriminant)     -- Larger root uses (+)
        denominator = 2 * a
        descriminant = (b * b - 4 * a * c)      -- Descriminant = b^2 - 4ac


--Exercise
doubleAll :: [Integer] -> [Integer]
doubleAll [] = []
doubleAll (x:xs) = (2*x) : (doubleAll xs)

doubleAll' :: [Integer] -> [Integer]
doubleAll' xs = [2*x | x <- xs]

doubleAll'' = map (\x->2*x) 


--Exercise
capitalize :: String -> String
capitalize [] = []
capitalize (next:rest) = (upperCase next) : capitalize rest where
    upperCase :: Char -> Char
    upperCase ch = toEnum (fromEnum ch - 32)

capitalizeLetters :: String -> String
capitalizeLetters [] = []
capitalizeLetters (next:rest) 
    | isLowerCaseLetter next    = (upperCase next) : capitalizeLetters rest
    | isUpperCaseLetter next    = next : capitalizeLetters rest
    | otherwise                 = capitalizeLetters rest
    where
        isLowerCaseLetter ch = ch <= 'z' && ch >= 'a'
        isUpperCaseLetter ch = ch <= 'Z' && ch >= 'A'
        upperCase ch = toEnum (fromEnum ch - 32)

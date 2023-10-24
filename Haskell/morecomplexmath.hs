
-- myExponent
-- Takes an integer which represents an exponent over a base of 2. Calculates and
-- returns the value of 2^n.
myExponent :: Int -> Int
myExponent n
    | n < 0             = error "negative exponent" -- Assume we are only working with + exponents
    -- Base cases
    | n == 0            = 1
    | n == 2            = 2 * 2     -- Without base case n == 2 it calculates one too many 2's
    -- Recursive case: even exponent
    | n `rem` 2 == 0    = myExponent (n `div` 2) ^2 -- evaluates to (2^m)^2
    -- Recursive case: odd exponent
    | otherwise         = 2 * myExponent (n-1)  -- with recursion, evaluates to 2*(2^m)^2

-- divisors
-- Takes an integer n and returns a list of integers which n 
-- is divisible by, including 1 and n.
divisors :: Integer -> [Integer]
divisors n
    -- Base case (also returns empty list for invalid inputs)
    | n < 1     = []
    -- Recursive case
    | otherwise = [x | x <- [1 .. n], n `mod` x == 0]   -- list comprehension
                            -- Applies filtering on a list of integers from 1 to n, only
                            -- including integers which n is divisible by

-- isPrime
-- Takes an integer and returns True if it is prime, False otherwise.
-- I assume that 1 is not a prime number (as defined in previous math courses).
isPrime :: Integer -> Bool
isPrime n
    -- Check for valid input
    | n < 1 = False
    -- Return True if it only has 2 divisors (will always be 1 and n)
    | length (divisors n) == 2 = True
    -- Return False if it has more or fewer than 2 divisors
    | otherwise = False

-- instrictorder
-- Takes a list of Ints and checks that the elements in the list are strictly decreasing
instrictorder :: [Int] -> Bool
instrictorder [] = True     -- Vacuously true
instrictorder (x:xs) = satisfies x xs   -- Evaluate by calling a helper function
    where
        -- Base case
        satisfies x [] = True
        -- Recursive case
        satisfies x (a:as) = if a < x then satisfies a as else False    -- Recurse through the 
                                                    -- list, evlauating entries next to each
                                                    -- other. Return false if there are any
                                                    -- two next to each other that are not
                                                    -- strictly decreasing.

-- binom
-- Takes two integers (k and n) and computes their binomial coefficient.
binom :: Integer -> Integer -> Integer
binom k n
    -- Check for valid input
    | n < 1 || (k < 0 || k > n) = error "inputs out of bounds"
    -- Special case
    | k == 0                    = 1
    -- Calculate binomial coefficient using given formula
    | otherwise                 = numerator `div` denominator
    where
        -- Use foldr with multiplication to evaluate the numerator and denominator
        numerator = foldr (*) n [n-1, n-2 .. n-k+1] -- n * (n-1) * ... * (n-k+1)
        denominator = foldr (*) 1 [2 .. k]          -- 1 * 2 * ... * k

-- duplicate
-- Takes a string and an integer n and returns a string which is the input string
-- repeated n times.
duplicate :: String -> Integer -> String
duplicate str n
    -- Base cases
    | n <= 0 = ""
    | n == 1 = str
    -- Recursive case
    | otherwise = str ++ duplicate str (n-1)    -- concatenate the string n times


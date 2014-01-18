module Main where

import Data.List

data BiSet a = Mk [a] [a]
    deriving (Show)

newtype Game = MkGame { unGame :: BiSet Game }

instance Show Game where
    show g@(MkGame (Mk l r))
        | g == zero = "0"
        | g == one  = "1"
        | g == -one = "-1"
        | g == two  = "2"
        | g == -two = "-2"
        | g == star = "*"
        | otherwise = "{ " ++ show' l ++ " | " ++ show' r ++ " }"
            where show' = concat . intersperse "," . map show

left :: Game -> [Game]
left (MkGame (Mk l r)) = l

right :: Game -> [Game]
right (MkGame (Mk l r)) = r

instance Ord Game where
    x >= y = null [xR | xR <- right x, xR <= y] && null [yL | yL <- left y, x <= yL]
    x >  y = x >= y && not (x == y)
    x <= y = y >= x
    compare x y = undefined  -- if x <= y then if x == y then EQ else LT else GT

instance Eq Game where
    x == y = x >= y && y >= x

instance Num Game where
    x + y = MkGame $ Mk
        ( [xL + y | xL <- left x]  ++ [x + yL | yL <- left y] )
        ( [xR + y | xR <- right x] ++ [x + yR | yR <- right y] )

    negate x = MkGame $ Mk [-xR | xR <- right x] [-xL | xL <- left x]

    (*)    = error "*"
    abs    = error "abs"
    signum = error "signum"

    fromInteger n
        | n == 0 = zero
        | n >  0 = one + fromInteger (n - 1)
        | n <  0 = negate $ fromInteger $ negate n

zero = MkGame $ Mk [] []
one  = MkGame $ Mk [zero] []
two  = strip $ one + one
onehalf = MkGame $ Mk [zero] [one]
star = MkGame $ Mk [zero] [zero]

birthday :: Game -> Game
birthday x = MkGame $ Mk [birthday x' | x' <- left x ++ right x] []

isNumber :: Game -> Bool
isNumber x = null [(xL, xR) | xL <- left x, xR <- right x, xL >= xR]

strip :: Game -> Game
strip (MkGame (Mk l r)) = MkGame $ Mk l' r'
    where
    l' = if null l then [] else [strip $ maximum l]
    r' = if null r then [] else [strip $ minimum r]

ordinalAddOne :: Game -> Game
ordinalAddOne x = MkGame $ Mk (zero : map ordinalAddOne (left x)) (map ordinalAddOne (right x))

nim :: Int -> Game
nim n | n < 0 = error "nim negative"
nim n = mkImp [nim n' | n' <- [0..n-1]]

mex :: [Int] -> Int
mex xs = head $ filter (`notElem` xs) [0..]

mkImp :: [Game] -> Game
mkImp xs = MkGame $ Mk xs xs

grundy :: Game -> Int
grundy (MkGame (Mk xs _)) = mex $ map grundy xs

box :: Int -> Game
box n | n < 0 = error "box negative"
box n = mkImp [box x + box y | x <- [0..n], y <- [x..n], x + y < n]

subtr :: Int -> Int -> Game
subtr k n | n < 0 = error "subtract negative"
subtr k n = mkImp [subtr k n' | n' <- [n-k..n-1], n' >= 0]

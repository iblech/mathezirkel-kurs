module Main where
-- Usage: ./graham 3 100

import Text.Printf
import System.Environment

main :: IO ()
main = do
    [b, k] <- map read <$> getArgs
    mapM_ (\(i,x) -> printf ("%d↑↑%" ++ show (length (show k)) ++ "d = %0" ++ show k ++ "d\n") b i x) $
        zip [(0::Int)..] $ iterate' (raise (10^k) b) 1

iterate' :: (Eq a) => (a -> a) -> a -> [a]
iterate' f x = let y = f x in if x /= y then x : iterate' f y else [x]

raise :: Integer -> Integer -> Integer -> Integer
raise m b n
    | n == 0    = 1
    | even n    = let x = raise m b (n `div` 2) `mod` m in (x*x) `mod` m
    | otherwise = (raise m b (pred n) * b) `mod` m

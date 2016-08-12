module Main where

import Control.Monad
import System.IO

restrict :: (Eq b, Eq c) => (a -> b) -> (a -> c) -> [a] -> b -> [Bool] -> [a]
restrict phi psi xs v []     = filter ((== v) . phi) xs
restrict phi psi xs v (b:bs) = do
    x <- xs
    guard $ phi x == v
    let theirGuesses = restrict psi phi xs (psi x) bs
    guard $ not . null $ theirGuesses
    guard $ b == (length theirGuesses == 1)
    return x

works phi psi xs x bs n =
    n /= 0 && if isSingleton (restrict phi psi xs (phi x) bs)
        then True  -- isSingleton (restrict psi phi xs (psi x) (True:bs))
        else works psi phi xs x (False:bs) (n-1)

isSingleton xs = length xs == 1

main = do
    hSetBuffering stdout NoBuffering
    forM_ [1..20] $ \n -> do
        let xs = [(i,j) | i <- [1..n], j <- [1..i-1]]
        forM_ xs $ \x -> do
            print (n, x)
            if works (\(a,b) -> a+b) (\(a,b) -> a*b) xs x [] 10 then return () else do
            putStrLn ":-("

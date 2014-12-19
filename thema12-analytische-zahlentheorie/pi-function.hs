module Main where

import Data.Numbers.Primes
import Control.Monad
import Text.Printf
import Text.Printf
import System.Environment

pi' x = countWhile ((<= x) . fromIntegral) primes :: Int

countWhile phi xs = go 0 xs
    where
    go acc [] = acc
    go acc (x:xs)
        | phi x     = go (acc+1) xs
        | otherwise = acc

ld x = log x / log 2

main = do
    args <- getArgs
    let xs = case args of
                []      -> iterate (10*) 1
                [delta] -> [(0::Double),read delta..]
    forM xs $ \x ->
        printf "%f\t%d\t%f\t%f\t%f\t%f\n"
            x (pi' x) (x / log x) (fromIntegral (pi' x) / (x / log x)) (ld (ld x)) (log x)

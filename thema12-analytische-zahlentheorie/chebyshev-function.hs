module Main where

import Data.List
import Data.Numbers.Primes
import Control.Monad
import Text.Printf
import System.Environment

lambda n
    | n < 0                       = undefined
    | n == 0                      = 0
    | [p] <- nub (primeFactors n) = log (fromIntegral p)
    | otherwise                   = 0

psi x = sum [ lambda n | n <- [0..floor x] ]

main = do
    [delta] <- getArgs
    forM [(0::Double),read delta..] $ \x -> printf "%f\t%f\n" x (psi x :: Double)

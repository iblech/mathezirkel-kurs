module Main where

import Data.List
import Data.Numbers.Primes
import Control.Monad
import Text.Printf

lambda n
    | n < 0                       = undefined
    | n == 0                      = 0
    | [p] <- nub (primeFactors n) = log (fromIntegral p)
    | otherwise                   = 0

main = do
    forM [(0::Int)..] $ \n -> printf "%d\t%f\n" n (lambda n :: Double)

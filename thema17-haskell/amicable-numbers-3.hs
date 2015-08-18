-- Idee von https://wiki.haskell.org/Euler_problems/21_to_30 (Problem 21)
module Main where

import Data.List (group)

main = mapM_ print [ (n,m) | n <- [2..], let m = sumProperDivisors n, n == sumProperDivisors m ]

sumProperDivisors n = product as - n
    where
    as =
        [ (p^(k+1) - 1) `div` (p-1)
        | g <- group (primeFactors n)
        , let p = head g
        , let k = length g
        ]

primeFactors = pf primes
    where
    pf ps@(p:ps') n
        | p * p > n = if n == 1 then [] else [n]
        | r == 0    = p : pf ps q
        | otherwise = pf ps' n
        where (q,r) = n `divMod` p

primes = 2 : filter (null . tail . primeFactors) [3,5..]

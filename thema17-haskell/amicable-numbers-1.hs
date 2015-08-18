module Main where

properDivisors n = [ k | k <- [1..n-1], n `mod` k == 0 ]

isAmicablePair (n,m) = sum (properDivisors n) == m && sum (properDivisors m) == n

main = mapM_ print [ (n,m) | n <- [1..], m <- [1..n-1], isAmicablePair (n,m) ]

module Main where

import Text.Printf
import Control.Monad

main = do
    forM [(1::Int)..] $ \i -> do
        printf "10^%d:\t" i
        printf "%f\n" $ go (10^i) 0

go :: Int -> Double -> Double
go 1 acc = acc + 1
go n acc = go (n-1) (acc + 1/fromIntegral n)

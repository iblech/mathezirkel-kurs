module Main where

cf x = a : cf (1 / (x - fromIntegral a))
    where a = floor x

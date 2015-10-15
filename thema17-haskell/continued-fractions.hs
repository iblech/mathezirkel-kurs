module Main where

cf x = a : cf (1 / (x - fromIntegral a))
    where a = floor x

cf' x = a : if x == fromIntegral a then [] else cf' (1 / (x - fromIntegral a))
    where a = floor x

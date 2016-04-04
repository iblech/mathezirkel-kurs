module Main where

pascalsTriangle = [1] : map (\xs -> [1] ++ zipWith (+) xs (tail xs) ++ [1]) pascalsTriangle

module Main where

import Data.List
import System.Random
import Control.Monad

numberOfRuns :: (Eq a) => [a] -> Int
numberOfRuns = length . group

repeatedCoin :: Int -> IO [Bool]
repeatedCoin = flip replicateM randomIO

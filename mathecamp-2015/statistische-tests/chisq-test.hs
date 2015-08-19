module Main where

import Data.List
import System.Random
import Control.Monad

table :: Int -> Int -> Int -> IO (Int -> Int -> Int)
table a b n = liftM (liftM (liftM sum)) $ replicateM n $ do
    x <- pick [0..a-1]
    y <- pick [0..b-1]
    return $ \x' y' -> if x' == x && y' == y then 1 else 0

pick :: [a] -> IO a
pick xs = randomRIO (0, length xs - 1) >>= return . (xs !!)

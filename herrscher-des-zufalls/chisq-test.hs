module Main where

import Data.List
import System.Random
import Control.Monad
import qualified Data.Map as M
import Text.Printf

table :: (Int,Int) -> Int -> IO (M.Map (Int,Int) Int)
table (a,b) n = liftM sum' $ replicateM n $ do
    x <- pick [0..a-1]
    y <- pick [0..b-1]
    return $ M.fromList [((x,y), 1)]
    where sum' = M.unionsWith (+)

pretty :: (Int,Int) -> M.Map (Int,Int) Int -> String
pretty (a,b) t =
    concat [ concat [printf "%d\t" (t M.! (i,j)) | j <- [0..b-1] ] ++ "\n" | i <- [0..a-1] ]

chisq :: (Int,Int) -> Int -> (M.Map (Int,Int) Int) -> Double
chisq (a,b) n t =
    sum [ (fromIntegral (t M.! (i,j)) - tstar M.! (i,j))^2 / tstar M.! (i,j) | i <- [0..a-1], j <- [0..b-1] ]
    where
    tstar = M.fromList $ do
        i <- [0..a-1]
        j <- [0..b-1]
        return ((i,j), fromIntegral (sum [ t M.! (i,k) | k <- [0..b-1] ] * sum [ t M.! (k,j) | k <- [0..a-1] ]) / fromIntegral n)

main :: IO ()
main = replicateM_ 10000 $ table (a,b) n >>= print . chisq (a,b) n
    where
    (a,b) = (3,4)
    n     = 650

pick :: [a] -> IO a
pick xs = randomRIO (0, length xs - 1) >>= return . (xs !!)

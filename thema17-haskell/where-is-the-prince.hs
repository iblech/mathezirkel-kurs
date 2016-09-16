module Main where

import Control.Monad

type Room = Int
data Dir  = L | R deriving (Show,Eq)

allPrincessStrategies :: Int -> Int -> [[Room]]
allPrincessStrategies n k = replicateM k [0..n-1]

allPrinceMoves :: Int -> [[Dir]]
allPrinceMoves k = replicateM k [L,R]

visitedRooms :: Int -> Room -> [Dir] -> [Room]
visitedRooms n = scanl move
    where
    move m _ | m == 0   = 1
    move m _ | m == n-1 = n-2
    move m L            = m - 1
    move m R            = m + 1

allPrinceStrategies :: Int -> Int -> [[Room]]
allPrinceStrategies n k = do
    start <- [0..n-1]
    moves <- allPrinceMoves (k-1)
    return $ visitedRooms n start moves

isWinningStrategy :: Int -> [Room] -> Bool
isWinningStrategy n xs = all (or . zipWith (==) xs) $ allPrinceStrategies n (length xs)

shortestWinningStrategies :: Int -> [[Room]]
shortestWinningStrategies n = go 1
    where
    go k = if null ss then go (k+1) else ss
        where ss = filter (isWinningStrategy n) (allPrincessStrategies n k)

bestWinningStrategy :: Int -> [Room]
bestWinningStrategy = head . shortestWinningStrategies

main :: IO ()
main = forM_ [1..] $ print . shortestWinningStrategies

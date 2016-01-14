{-# LANGUAGE TupleSections, DeriveFunctor #-}
module Main where

import Data.Ratio
import Data.List

data Tree a = Nil | Fork a (Tree a) (Tree a)
    deriving (Show,Eq,Functor)

type Rat = (Integer,Integer)

sternBrocot :: Tree Rat
sternBrocot = mk (0,1) (1,0)

-- Anwendung: approximate (compare pi . fromRational)
approximate :: (Rational -> Ordering) -> [Rational]
approximate phi = go sternBrocot
    where
    go (Fork x l r)
        | EQ <- phi x' = [x']
        | LT <- phi x' = x' : go l
        | GT <- phi x' = x' : go r
        where x' = fromRat x

fromRat :: Rat -> Rational
fromRat = uncurry (%)

mk :: Rat -> Rat -> Tree Rat
mk x@(m,n) x'@(m',n') = Fork y (mk x y) (mk y x')
    where
    y = (m + m', n + n')

cut :: Int -> Tree a -> Tree a
cut 0 t   = Nil
cut n Nil = Nil
cut n (Fork x l r) = Fork x (cut (n-1) l) (cut (n-1) r)

leaves :: Int -> Tree a -> [a]
leaves 0 (Fork x l r) = [x]
leaves n (Fork x l r) = leaves (n-1) l ++ leaves (n-1) r

connections :: Tree a -> [(a,a)]
connections Nil          = []
connections (Fork x l r) = map (x,) (labels l ++ labels r) ++ connections l ++ connections r
    where
    labels Nil          = []
    labels (Fork a _ _) = [a]

graphviz :: Tree String -> String
graphviz t = concat $ concat
    [ ["digraph tree { rankdir=LR; node [ shape=box ]; "]
    , intersperse ";" $ map (\(src,dst) -> show src ++ " -> " ++ show dst) $ connections t
    , ["}"]
    ]

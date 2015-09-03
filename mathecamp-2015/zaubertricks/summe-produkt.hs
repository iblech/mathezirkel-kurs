{-# LANGUAGE ExistentialQuantification #-}
module Main where

import Control.Monad.Writer
import qualified Data.List
import System.Environment

-- Ein geheimer Zustand x aus xs wird gezogen.
-- Spieler 1 erfährt f x, Spieler 2 erfährt g x.
-- Spieler 1 und Spieler 2 treffen dann abwechselnd wahrheitsgemäß eine der
-- folgenden Aussagen: "Ich kenne den geheimen Zustand." oder "Ich kenne den
-- geheimen Zustand nicht."
--
-- knows f g ist eine Liste. Deren n-te Element (as,bs) ist ein Tupel von
-- Zustandslisten mit folgender Eigenschaft: Wenn der geheime Zustand aus as
-- ist, so kann Spieler 1 diesen Zustand im n-ten Spielzug identifizieren,
-- unter der Voraussetzung dass es entweder Spieler 2 im vorherigen Spielzug
-- nicht konnte oder dass er es konnte.
--
-- Das Filtern der Zustände aus dem vor-vorherigen Schritt bringt nicht so viel.
knows :: (Eq a, Eq r, Eq s) => (a -> r) -> (a -> s) -> [a] -> [([a],[a])]
knows f g xs = takeWhile (\(as,bs) -> not (null as && null bs)) $ tail rs
    where
    rs = ([], []) : map step rs
    step (as,bs) = (filter (`notElem` as) $ go f bs, filter (`notElem` bs) $ go g as)
    go h ys =
        [ x
        | x <- xs
        , length (filter (\x' -> h x' == h x && x' `notElem` ys) xs) == 1 ||
            length (filter (\x' -> h x' == h x) ys) == 1
        ]

-- Gemeint: positive natürliche Zahl
type Nat = Int

-- Die Liste derjenigen geheimen Zustände, bei denen Spieler 1 bzw. Spieler 2
-- schlussendlich in der Lage ist, den Zustand zu erraten.
winningStates :: (Eq a, Eq r, Eq s) => (a -> r) -> (a -> s) -> [a] -> ([a], [a])
winningStates f g xs = (collect (map fst ys), collect (map snd ys)) where
    ys      = knows f g xs
    collect = Data.List.nub . foldr1 Data.List.union

-- Demo: Gibt die Zustände aus, bei denen beide Spieler schlussendlich in der
-- Lage sind, den Zustand zu erraten. Der geheime Zustand ist ein ungeordnetes
-- Paar aus { 1, ..., n }, Spieler 1 wird die Summe und Spieler 2 wird das
-- Produkt mitgeteilt.
--
-- Terminiert genau dann, wenn alle Zustände für beide Spieler erratbar sind.
-- In http://mathoverflow.net/a/31656/31233 wird behauptet, dass das stets der
-- Fall ist. Das sehe ich aber nicht. Sei etwa n = 3 und der geheime Zustand
-- (2,2). Dann kommen für Spieler 1 in Frage: (2,2) und (3,1). Und für Spieler 2:
-- nur (2,2). Spieler 2 kann also sofort lösen. Aber diese Information scheint
-- Spieler 1 nicht zu genügen.
main = do
    [n] <- liftM (map read) getArgs
    let (as,bs) = winningStates (uncurry (+)) (uncurry (*)) space
        space   = [ (a,b) | a <- [1..n], b <- [1..a] ]
        m       = (n * (n+1)) `div` 2
    mapM_ print $ take m $ as `Data.List.intersect` bs

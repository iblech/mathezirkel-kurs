-- Programm zum Rechnen mit (endlichen) surrealen Zahlen und Games,
-- in der Programmiersprache Haskell.
--
-- Einen ersten Einblick in Haskell erhält man etwa unter
-- http://tryhaskell.org/.
module Main where

import Data.List


---- Grundlegende Definitionen.

-- Datentyp für "Bimengen": Diese bestehen aus einer linken Liste von Werten
-- und einer rechten Liste von Werten.
data BiSet a = Mk [a] [a]
    deriving (Show)

-- Ein Game besteht aus einer linken Menge von Games und einer rechten Menge
-- von Games.
newtype Game = MkGame { unGame :: BiSet Game }

-- Die Funktion show gibt an, wie Games ausgegeben werden sollen. Für manche
-- Games führen wir ihre Trivialnamen.
instance Show Game where
    show g@(MkGame (Mk l r))
        | g == zero = "0"
        | g == one  = "1"
        | g == -one = "-1"
        | g == two  = "2"
        | g == -two = "-2"
        | g == star = "*"
        | otherwise = "{ " ++ show' l ++ " | " ++ show' r ++ " }"
            where show' = concat . intersperse "," . map show

-- Gibt die linke Menge eines Games zurück.
left :: Game -> [Game]
left (MkGame (Mk l r)) = l

-- Gibt die rechte Menge eines Games zurück.
right :: Game -> [Game]
right (MkGame (Mk l r)) = r

-- Definition der Ordnungsstruktur auf den Games.
-- Da Games nicht total geordnet sind (ein Game kann größer, kleiner oder gleich
-- einem weiteren Game sein -- oder nichts davon), lassen wir die
-- compare-Methode undefiniert.
instance Ord Game where
    x >= y = null [xR | xR <- right x, xR <= y] && null [yL | yL <- left y, x <= yL]
    x >  y = x >= y && not (x == y)
    x <= y = y >= x
    compare x y = undefined

-- Definition der Gleichheit zweier Games.
instance Eq Game where
    x == y = x >= y && y >= x

-- Definition der Rechenoperationen auf Games.
instance Num Game where
    x + y = MkGame $ Mk
        ( [xL + y | xL <- left x]  ++ [x + yL | yL <- left y] )
        ( [xR + y | xR <- right x] ++ [x + yR | yR <- right y] )

    negate x = MkGame $ Mk [-xR | xR <- right x] [-xL | xL <- left x]

    (*)    = error "*"  -- zu faul
    abs    = error "abs"
    signum = error "signum"

    fromInteger n
        | n == 0 = zero
        | n >  0 = one + fromInteger (n - 1)
        | n <  0 = negate $ fromInteger $ negate n

-- Definitionen mancher wichtiger Games.
zero = MkGame $ Mk [] []
one  = MkGame $ Mk [zero] []
two  = strip $ one + one
onehalf = MkGame $ Mk [zero] [one]
star = MkGame $ Mk [zero] [zero]

-- Berechnet den Geburtstag eines Games, über dieselbe Definition
-- wie in den Aufgaben. Es gibt also auch hier das Manko, dass gleiche
-- Games nicht unbedingt denselben Geburtstag haben; das sollte nicht sein.
birthday :: Game -> Game
birthday x = MkGame $ Mk [birthday x' | x' <- left x ++ right x] []

-- Prüft, ob ein gegebenes Game eine surreale Zahl ist.
isNumber :: Game -> Bool
isNumber x = null [(xL, xR) | xL <- left x, xR <- right x, xL >= xR]

-- Vereinfacht eine surreale Zahl gemäß der Vereinfachungsregel
-- aus den Aufgaben: In der linken Menge können kleinere, in der rechten Menge
-- größere Zahlen weggelassen werden.
strip :: Game -> Game
strip (MkGame (Mk l r)) = MkGame $ Mk l' r'
    where
    l' = if null l then [] else [strip $ maximum l]
    r' = if null r then [] else [strip $ minimum r]

-- Berechnet die ordinale Summe mit Eins.
ordinalAddOne :: Game -> Game
ordinalAddOne x = MkGame $ Mk (zero : map ordinalAddOne (left x)) (map ordinalAddOne (right x))


---- Anwendung von Games zur Analyse kombinatorischer Spiele.

-- Funktion, um Schreibarbeit zu sparen: Zu einer Menge xs von Games
-- gibt diese das Game {xs|xs} zurück.
mkImp :: [Game] -> Game
mkImp xs = MkGame $ Mk xs xs

-- Berechnet das Meximum einer Liste von Zahlen, die alle als nichtnegativ
-- angenommen werden.
mex :: [Int] -> Int
mex xs = head $ filter (`notElem` xs) [0..]

-- Berechnet die Grundy-Zahl eines neutralen Games.
grundy :: Game -> Int
grundy (MkGame (Mk xs _)) = mex $ map grundy xs

-- Berechnet das Game, das die Situation eines Haufens der Größe n im Nim-Spiel
-- beschreibt. In den Aufgaben haben wir dieses Game *n genannt.
nim :: Int -> Game
nim n | n < 0 = error "nim negative"
nim n = mkImp [nim n' | n' <- [0..n-1]]

-- Berechnet das Game, das die Situation eines Haufens der Größe n
-- in der Variante des Nim-Spiels beschreibt, bei denen der ziehende Spieler
-- den verkleinerten Haufen nach Belieben in zwei Haufen aufteilen darf.
box :: Int -> Game
box n | n < 0 = error "box negative"
box n = mkImp [box x + box y | x <- [0..n], y <- [x..n], x + y < n]

-- Berechnet das Game, das die Situation eines Haufens der Größe n
-- in dem Subtraktionsspiel beschreibt, bei dem in jedem Zug
-- höchstens k Spielsteine eines Haufens entfernt werden dürfen.
subtr :: Int -> Int -> Game
subtr k n | n < 0 = error "subtract negative"
subtr k n = mkImp [subtr k n' | n' <- [n-k..n-1], n' >= 0]


---- Hauptprogramm.

main = do
    print $ nim 0
    print $ nim 1
    print $ nim 2
    print $ grundy $ box 7

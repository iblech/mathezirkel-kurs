{-# LANGUAGE GeneralizedNewtypeDeriving #-}

{-
  Von Sven.

  PS: Ein kleines Rätsel falls ihr es noch nicht kennt: Zwei Spieler,
  einer denkt sich ein Polynom beliebigen Grades mit nicht-negativen
  ganzzahligen Koeffizienten aus. Danach darf der andere Spieler eine
  ganze Zahl nennen woraufhin der erste den Wert des Polynoms an dieser
  Stelle nennt. Daraufhin darf der zweite Spieler den Wert des Polynoms
  an einer weiteren ganzzahligen Stelle erfragen. Wie kann der zweite
  Spieler das Polynom in zwei Anfragen dieser Art ermitteln?
-}

module Main where

import Test.QuickCheck
import Control.Monad

newtype Nat = MkNat Integer
    deriving (Show,Eq,Num,Integral,Enum,Real,Ord)

guess :: (Nat -> Nat) -> [Nat]
guess f = coeffs where
    m = f 1 + 1
    coeffs = go (f m)
    go n | n == 0 = []
    go n = n `mod` m : go ((n - n `mod` m) `div` m)

instance Arbitrary Nat where
    arbitrary = do
        x <- arbitrary
        if x < 0
            then arbitrary
            else return $ MkNat x

eval :: (Num a) => [a] -> a -> a
eval f x = foldr (\c val -> c + x*val) 0 f

test :: IO ()
test = quickCheck $ \f -> canon f == canon (guess (eval f))
    where canon = reverse . dropWhile (== 0) . reverse

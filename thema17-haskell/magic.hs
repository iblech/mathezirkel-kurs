-- Dieses Programm sucht magische Quadrate. Das sind (3x3)-Quadrate,
-- in deren Felder derart die Zahlen 1 bis 9 verteilt werden müssen,
-- sodass die Summen in jeder Zeile, jeder Spalte und den beiden
-- Diagonalen jeweils gleich sind.
module Main where

import Control.Monad

-- a1 a2 a3
-- a4 a5 a6
-- a7 a8 a9
magicSquares = do
    -- Vorgaben:
    -- ? 1 ?
    -- 3 ? ?
    -- ? ? 2
    let a2 = 1
    let a4 = 3
    let a9 = 2
    a1 <- [1..9]
    a3 <- [1..9]
    a1 <- [1..9]
    a5 <- [1..9]
    a6 <- [1..9]
    a7 <- [1..9]
    a8 <- [1..9]
    guard $ allEqual
        -- horizontal
        [ a1 + a2 + a3
        , a4 + a5 + a6
        , a7 + a8 + a9
        -- vertikal
        , a1 + a4 + a7
        , a2 + a5 + a8
        , a3 + a6 + a9
        -- diagonal
        , a1 + a5 + a9
        , a3 + a5 + a7
        ]
    return (a1,a2,a3,a4,a5,a6,a7,a8,a9)

allEqual (x:xs) = all (== x) xs

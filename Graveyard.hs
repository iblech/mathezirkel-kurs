-- http://nautil.us/blog/-the-logic-puzzle-you-can-only-solve-with-your-brightest-friend

module Graveyard where

commonKnowledge = [ (a,b) | a <- [0..20], b <- [0..20], a + b == 18 || a + b == 20 ]

optionsA a0 n
    | n == 0 = [ (a,b) | (a,b) <- commonKnowledge, a == a0 ]
    | n >  0 = [ (a,b) | (a,b) <- optionsA a0 (n-1), length (optionsB b (n-1)) >= 2 ]

optionsB b0 n
    | n == 0 = [ (a,b) | (a,b) <- commonKnowledge, b == b0 ]
    | n >  0 = [ (a,b) | (a,b) <- optionsB b0 (n-1), length (optionsA a n) >= 2 ]

solvable a0 b0 = go 0
    where
    go n
        | n == 8    = False
        | otherwise =
            let xs = optionsA a0 n
                ys = optionsB b0 n
            in  xs == [(a0,b0)] || (length xs > 1 && (ys == [(a0,b0)] || (length ys > 1 && go (n+1))))

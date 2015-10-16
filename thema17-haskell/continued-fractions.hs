module Main where

-- Berechnet die Kettenbruchentwicklung einer Zahl, in der Annahme, dass alle
-- auftretenden Reste verschieden von Null sind.
cf x = a : cf (1 / (x - fromIntegral a))
    where a = floor x

-- Berechnet die Kettenbruchentwicklung einer Zahl. Terminiert bei Auftreten
-- eines verschwindenden Rests.
cf' x = a : if x == fromIntegral a then [] else cf' (1 / (x - fromIntegral a))
    where a = floor x

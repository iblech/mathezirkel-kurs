p = 10

add xs ys = normalize $ zipWithDefault 0 (+) xs ys

mul [] ys = []
mul (x:xs) ys = normalize $
    map (x*) ys `add` (0:xs `mul` ys)

funny = iterate (\xs -> xs `mul` xs) [5]
-- funny gibt Annäherungen an eine Zahl, deren Quadrat sie selbst ist.

normalize [] = []
normalize (x:xs)
    | 0 <= x && x < p = x : normalize xs
    | x >= p          = normalize ((x-p) : mapFirst (1 +) xs)
    where
    mapFirst f []     = [f 0]
    mapFirst f (x:xs) = f x : xs

zipWithDefault z (#) [] ys = map (z #) ys
zipWithDefault z (#) xs [] = map (# z) xs
zipWithDefault z (#) (x:xs) (y:ys) = (x # y) : zipWithDefault z (#) xs ys

-- Zeuge, dass Z_10 kein Integritätsbereich ist:
-- mapM_ (putStrLn . pad 100 . show) $ take 100 $ map (\i -> powermod (10^i) 5 (2^i)) [1..]
-- let powermod m n i = if i == 0 then 1 else if i == 1 then n `mod` m else if i `mod` 2 == 0 then ((powermod m n (i `div` 2)) ^ 2) `mod` m else (n * powermod m n (i-1)) `mod` m
-- let pad n xs = replicate (n - length xs) ' ' ++ xs

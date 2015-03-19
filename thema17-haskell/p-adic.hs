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

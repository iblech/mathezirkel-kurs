qsort []     = []
qsort (x:xs) =
    qsort kleinere ++ [x] ++ qsort groessere
    where
    kleinere  = [y | y <- xs, y <= x]
    groessere = [y | y <- xs, y > x]

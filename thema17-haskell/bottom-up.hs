-- https://projecteuler.net/index.php?section=problems&id=18
-- http://stackoverflow.com/a/789945/4533618

bottomUp :: (Ord a, Num a) => [[a]] -> a
bottomUp = head . bu
  where bu [bottom]     = bottom
        bu (row : base) = merge row $ bu base
        merge [] [_] = []
        merge (x:xs) (y1:y2:ys) = x + max y1 y2 : merge xs (y2:ys)

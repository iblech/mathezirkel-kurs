fibs     = 1 : 2 : zipWith (+) fibs (tail fibs)

xs       = filter even $ takeWhile (<= 4000000) fibs

solution = sum xs

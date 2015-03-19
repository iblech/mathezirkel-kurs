f  x = x^2 - x - 6
f' x = 2*x - 1

newton g g' x0 = iterate (\x -> x - g x / g' x) x0

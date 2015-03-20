import Control.Monad

data Complex = C Double Double
    deriving (Show,Eq)

instance Num Complex where
    C x y + C x' y' = C (x+x') (y+y')
    C x y * C x' y' = C (x*x' - y*y') (x*y' + x'*y)

    fromInteger n = C (fromInteger n) 0

    abs    = error "abs"
    signum = error "signum"

magnitude :: Complex -> Double
magnitude (C x y) = sqrt (x^2 + y^2)

mandelbrot :: Complex -> Complex
mandelbrot a = iterate (\z -> z^2 + a) 0 !! 200

julia :: Complex -> Complex -> Complex
julia a z0 = iterate (\z -> z^2 + a) z0 !! 100

main = mapM_ putStrLn
    [ [if magnitude (mandelbrot (C x y)) < 2 then '*' else ' ' | x <- [-2, -1.9685 .. 0.5]]
      | y <- [1, 0.95 .. -1]]

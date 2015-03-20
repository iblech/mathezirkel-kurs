import Control.Monad

add (x,y) (x',y') = (x+x', y+y')
mul (x,y) (x',y') = (x*x' - y*y', x*y' + x'*y)

magnitude (x,y) = sqrt (x^2 + y^2)

mandelbrot a = iterate (\z -> (z `mul` z) `add` a) (0,0) !! 200

main = mapM_ putStrLn
    [ [if magnitude (mandelbrot (x,y)) < 2 then '*' else ' ' | x <- [-2, -1.9685 .. 0.5]]
      | y <- [1, 0.95 .. -1]]

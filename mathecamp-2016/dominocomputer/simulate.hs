{-# LANGUAGE FlexibleContexts #-}
module Main where

import Control.Applicative
import Data.Maybe
import Control.Monad.Writer
import qualified Data.Map as M
import Text.Printf

type Time      = Double
type TimeDelta = Double
type Pos       = (Double,Double)

data Elem
    = Link   { begin   :: Maybe Time, toppled :: Maybe Time, posFrom :: Pos, pos :: Pos }
    | Sink   { toppled :: Maybe Time, pos :: Pos }
    | Source { toppled :: Maybe Time, pos :: Pos }
    deriving (Show)

type M = Writer [Elem]

tell' :: MonadWriter [b] m => b -> m b
tell' x = tell [x] >> return x

left :: Double -> Pos -> Pos
left a (x, y) = (x-a, y)

right :: Double -> Pos -> Pos
right a (x, y) = (x+a, y)

down :: Double -> Pos -> Pos
down a (x, y) = (x, y-a)

source :: Bool -> Pos -> M Elem
source on p = tell' $ Source
    { toppled = if on then Just 0 else Nothing
    , pos     = p
    }

link :: Elem -> TimeDelta -> (Pos -> Pos) -> M Elem
link from len posFun
    | Nothing <- toppled from
    = tell' e
    | Just t <- toppled from
    = tell' $ e { begin = Just t, toppled = Just (t + len) }
    where e = Link
            { begin   = Nothing
            , toppled = Nothing
            , posFrom = pos from
            , pos     = posFun (pos from)
            }

fork :: Elem -> M (Elem,Elem)
fork from = (,) <$> link from 0 id <*> link from 0 id

unfork :: Elem -> Elem -> M Elem
unfork e1 e2
    | Nothing <- toppled e1
    = tell' $ Source { pos = pos e1, toppled = toppled e2 }
    | Nothing <- toppled e2
    = tell' $ Source { pos = pos e1, toppled = toppled e1 }
    | Just t1 <- toppled e1, Just t2 <- toppled e2
    = tell' $ Source { pos = pos e1, toppled = toppled e1 `min` toppled e2 }

trans :: Elem -> Elem -> M Elem
trans controller input =
    let doStop = (<) <$> toppled controller <*> toppled input
    in  if doStop == Nothing
        then tell' $ Source { pos = pos controller, toppled = toppled input }
        else tell' $ Sink   { pos = pos controller, toppled = Nothing }

sink :: Elem -> M Elem
sink e = tell' $ Sink { toppled = toppled e, pos = pos e }

andGate :: Elem -> Elem -> M Elem
andGate a b = do
    a' <- link a 50 (down 50)
    b' <- link b 50 (down 50)
    (x,y) <- fork a'
    x' <- link x 50 (left 50)
    z <- trans b' x'
    z' <- link z 50 (left 50)
    z'' <- link z' 50 (down 50)
    y' <- link y 50 (right 50)
    y'' <- link y' 50 (down 50)
    y''' <- link y'' 150 (left 150)
    w <- trans z'' y'''
    w' <- link w 50 (left 50)
    w'' <- link w' 50 (down 50)
    s <- sink w''
    return s

collide :: Elem -> Elem -> M (Elem,Elem)
collide a b = do
    a <- link a 50 (down 50)
    b <- link b 50 (down 50)
    a' <- link a 72 (left 60 . down 40)
    b' <- link b 72 (right 60 . down 40)
    a' <- link a' 40 (left 40)
    b' <- link b' 40 (right 40)
    a <- link a 50 (right 50)
    a <- link a 10 (down 10)
    a <- link a 30 (left 30)
    a <- link a 10 (down 10)
    a <- link a 30 (right 30)
    a <- link a 20 (down 20)
    a <- trans b' a
    a <- link a 50 (down 10)
    a <- link a 50 (left 50)
    b <- link b 50 (left 50)
    b <- link b 10 (down 10)
    b <- link b 30 (right 30)
    b <- link b 10 (down 10)
    b <- link b 30 (left 30)
    b <- link b 20 (down 20)
    b <- trans a' b
    b <- link b 50 (down 10)
    b <- link b 50 (right 50)
    a <- link a 20 (down 20)
    b <- link b 20 (down 20)
    return (a,b)

xorGate :: Elem -> Elem -> M Elem
xorGate a b = do
    (a,b) <- collide a b
    a <- link a 35 (left 25 . down 25)
    b <- link b 35 (right 25 . down 25)
    c <- unfork a b
    link c 10 (down 10)

xorGate' :: Elem -> Elem -> M Elem
xorGate' a b = do
    a <- link a 50 (down 50)
    b <- link b 50 (down 50)
    a <- link a 14 (left 10 . down 10)
    b <- link b 14 (right 10 . down 10)
    (a,b) <- undefined a b
    a <- link a 14 (left 10 . down 10)
    b <- link b 14 (right 10 . down 10)
    a <- link a 30 (down 30)
    b <- link b 30 (down 30)
    a <- link a 20 (right 20)
    b <- link b 20 (left 20)
    a <- link a 7 (right 5 . down 5)
    b <- link b 7 (left 5 . down 5)
    unfork a b

halfAdder :: Elem -> Elem -> M (Elem,Elem)
halfAdder a b = do
    a   <- link a   10  (down 10)
    a'  <- link a   100 (left 100)
    a'  <- link a'  20  (down 20)
    a'' <- link a   100 (right 100)
    a'' <- link a'' 20  (down 20)

    b   <- link b   20  (down 20)
    b'  <- link b   100 (left 100)
    b'  <- link b'  10  (down 10)
    b'' <- link b   100 (right 100)
    b'' <- link b'' 10  (down 10)

    s <- xorGate a'' b''
    c <- andGate a'  b'

    return (c,s)

svg :: [Elem] -> String
svg = (++ footer) . (header ++) . concatMap formatElem
    where
    formatElem e@(Link _ _ _ _) =
        printf "<line %s data-part='a' /><line %s data-part='b' />" (attrs :: String) attrs
        where
        attrs = printf "data-x1='%f' data-y1='%f' data-x2='%f' data-y2='%f' data-begin-time='%f' data-toppled-time='%f'"
            (fst (posFrom e)) (snd (posFrom e))
            (fst (pos     e)) (snd (pos     e))
            (maybe (1/0) id (begin e))
            (maybe (1/0) id (toppled e))
    formatElem _ = ""
    header = "<html><script type='text/javascript' src='jquery.min.js'></script><script type='text/javascript' src='ui.js'></script><style>line { stroke: rgb(0,0,0); stroke-width: 2; }</style><body onload=\"updateTime(0);$('#time').focus();\"><input id='time' type='range' step='10' min='0' max='600' value='0' onchange='updateTime(this.value)'><br><svg width='600' height='300'>"
    footer = "</svg></body></html>"

ex = do
    a <- source False (250,300)
    b <- source True  (200,300)
    halfAdder a b

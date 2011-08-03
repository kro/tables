{-# OPTIONS_GHC -XFlexibleInstances #-}
module Tables.DSL where

import Tables.Types

instance Num (E Double) where
  E x + E y = E (Add x y)
  E x - E y = E (Sub x y)
  E x * E y = E (Mult x y)
  fromInteger i = E (ExprD (fromInteger i))

dbl :: Double -> E Double
dbl = E . ExprD

ref :: Int -> E Double
ref id = E $ Ref id 

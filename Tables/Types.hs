module Tables.Types where

type CellId = Int
data Cell = Cell CellId (E Double)

type Graph = [(CellId, [CellId])]
type Bounds = (Int, Int)

{- Define a new type visible to the user -}
newtype E a = E Expr deriving (Show, Eq)

{- Define a data type which represent expressions -}
data Expr = ExprD Double 
         | Add Expr Expr
         | Sub Expr Expr
         | Mult Expr Expr
         | Ref Int deriving (Show, Eq)

{- A value type used as a result of evaluation -}
data Value = ValueD Double deriving (Show)

{- Data that reflects the current evaluation state -}
data EvalState = EvalState {
  vals :: [(CellId, Value)]
} deriving (Show)

data Table = Table Bounds [Cell]

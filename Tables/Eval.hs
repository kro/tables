module Tables.Eval where

import Control.Monad.State
import Data.List
import Data.Maybe
import Tables.Dependency
import Tables.Types
import Tables.Refs

evalTable :: Table -> [Value]
evalTable (Table bounds cells) = map snd $ sortBy (\(id1, _) (id2, _) -> compare id1 id2) $ zip cellIds values
 where 
    values       = reverse $ evalState (evalCells sortedCells []) (EvalState [])
    sortedCells  = map ((!!) cells) cellIds
    cellIds      = cellEvalOrder bounds $ cellsRefs cells

evalCells :: [Cell] -> [Value] -> State EvalState [Value]
evalCells [] vals = State(\state -> (vals, state))
evalCells cells vals = evalCell (head cells)
  >>= \val  -> State(\state -> (val : vals, state)) 
  >>= \vals -> evalCells (drop 1 cells) vals

evalCell :: Cell -> State EvalState Value
evalCell (Cell id expr) = evalExpr expr >>= \val -> State(\state -> (val, state' state val))
 where state' (EvalState vals) val = EvalState ((id, val) : vals)

evalExpr :: E a -> State EvalState Value
evalExpr (E expr) = evalExpr' expr

evalExpr' :: Expr -> State EvalState Value
evalExpr' (ExprD d) = State (\state -> (ValueD d, state))
evalExpr' (Add x y) = evalExpr' x >>= \x -> evalExpr' y >>= \y -> State (\state -> (add x y, state))
 where add x y = case (x, y) of (ValueD vx, ValueD vy) -> ValueD (vx + vy)
evalExpr' (Ref id) = State (\state -> (value state id, state)) 

value :: EvalState -> CellId -> Value
value (EvalState vals) cellId = snd $ fromJust $ find (\(id, val) -> cellId == id) vals

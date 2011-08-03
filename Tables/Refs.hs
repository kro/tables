module Tables.Refs (cellsRefs) where

import Tables.Types

cellsRefs :: [Cell] -> Graph
cellsRefs cells = map cellRefs cells

cellRefs :: Cell -> ((CellId), [CellId])
cellRefs (Cell id (E expr)) = (id, cellRefs' expr [])

cellRefs' :: Expr -> [CellId] -> [CellId]
cellRefs' (Ref id) refs = id : refs
cellRefs' (Add x y) refs = cellRefs' x refs ++ cellRefs' y refs
cellRefs' (ExprD _) refs = refs

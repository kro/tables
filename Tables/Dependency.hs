module Tables.Dependency (cellEvalOrder) where

import Data.Array
import Tables.Types
import qualified Data.Graph as DG

cellEvalOrder :: Bounds -> Graph -> [CellId]
cellEvalOrder bounds graph = reverse $ DG.topSort $ array bounds graph

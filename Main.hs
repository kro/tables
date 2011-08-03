import Tables

main = print $ evalTable table
 where 
    table = Table (0, 3)
      [ 
        Cell 0 (dbl 10.0), 
        Cell 1 ((dbl 2.0) + (ref 0) + (ref 2)),
        Cell 2 ((dbl 2.0) + (ref 0)),
        Cell 3 ((dbl 100) + (ref 2))
      ]

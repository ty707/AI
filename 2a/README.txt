load 15-puzzle.lisp in the REPL, then run (main <stats flag>).

Alternatively, you can choose your own s0 and sg with (15-puzzle <s0> <sg> <stats flag>).  I know you guys said in the addendum to have two arguments only, but I gave you the benefit of the doubt and assumed that you didn't have us implement optional statistic flags for nothing ^_^.

My heuristic function, row-and-column, computes how many tiles in a state are out of their proper row and those that are out of their proper column (relative to the goal state). I found it at http://heuristicswiki.wikispaces.com/Tiles+out+of+row+and+column.

I have omitted some time-consuming searches from the main driver function's hard lineup.  Feel free to run these slowpokes separately by compiling the individual lines in 15-puzzle.lisp.

There isn't much more to say about my submission except that the operations are saved in nodes as actual functions (ergo #<FUNCTION WEST> rather than a string like "W").  The solution path should still be clear from this output.

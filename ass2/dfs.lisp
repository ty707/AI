(defun dfs (s0 sg kids d)
  (let ((ahead `((,s0 ,nil ,nil))) ;list of unexplored nodes, starting with s0
	(behind nil) ;list of explored nodes
	(n nil)
	(children nil)) ;N
    (loop
       (if (null ahead) (return-from bfs "no goal state found :("))
       (setf n (pop ahead)) ;set N to first explored node
       (push (state n) behind)
       (if (equal (state n) sg) ;if goal state has been reached
	   (return-from bfs (solution n)))
					;collect n's child nodes into a list
       (setf children (remove nil (funcall kids n `(,#'north ,#'south ,#'east ,#'west)))) 
       (setf children ;get rid of nodes with states we already have/will cover
	     (diff children (append ahead behind)))
       (setf ahead (append ahead children))))) ;add newly generated nodes to frontier
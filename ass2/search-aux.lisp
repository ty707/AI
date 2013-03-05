;node accessor fxns
(defun state (node) (first node))
(defun action (node) (second node))
(defun parent (node) (third node))
(defun depth (node) (fourth node))

(defun diff (l1 l2)
  (cond
    ((or (null l1) (null l2)) l1)
    ((find-state (state (car l1)) l2) (diff (cdr l1) l2))
    (T (cons (car l1) (diff (cdr l1) l2)))))

(defun find-state (s ls)
  (cond
    ((null ls) nil)
    ((equal (state (car ls)) s) t)
    (t (find-state s (cdr ls)))))

(defun zero (n)
  (eq n 0))

(defun solution (n)
  (cond
    ((null n) (print 'Solution) n)
    (T (append (solution (parent n)) `(,(action n))))))

(defun pos (e ls)
  (cond
    ((equal e (car ls)) 0)
    (T (+ 1 (pos e (cdr ls))))))

(defun get-0-x (state) (cadr (getl (- (length state) 1) state)))
(defun get-0-y (state) (car (getl (- (length state) 1) state)))

(defun getl (n ls)
  (cond
    ((zero n) (car ls))
    (T (getl (- n 1) (cdr ls)))))

(defun setl (n ls e)
  (cond
    ((null ls) ls)
    ((zero n) (cons e (setl (- n 1) (cdr ls) e)))
    (T (cons (car ls) (setl (- n 1) (cdr ls) e)))))

(defun grid-get (x y grid)
  (cond
    ((null grid) grid)
    ((zero y) (getl x (car grid)))
    (T (grid-get x (- y 1) (cdr grid)))))

(defun grid-set (x y grid e)
    (cond
      ((null grid) grid)
      ((zero y) (cons (setl x (car grid) e) (grid-set x (- y 1) (cdr grid) e)))
      (T (cons (car grid) (grid-set x (- y 1) (cdr grid) e)))))

(defun backtrack? (op1 op2)
  (cond
    ((equal op1 #'north) (equal op2 #'south))
    ((equal op1 #'south) (equal op2 #'north))
    ((equal op1 #'east) (equal op2 #'west))
    ((equal op1 #'west) (equal op2 #'east))
    (t nil)))

(defun succ-fxn (node ops)
  (let ((s-nodes nil) (s-states nil) (n-state (state node)))
    (loop for op in ops
       do
	 (setf s-states `(,(funcall op n-state))) ;new states created
	 (setf s-nodes 
	       (append s-nodes
		      (mapcar (lambda (s-state) ;new states --> nodes
				(cond
				((null s-state) nil)
				((backtrack? op (action node)) nil)
				(t `(,s-state ,op ,node))))
			      s-states))))
    s-nodes))

;OPERATOR FUNCTIONS FOR N-PUZZLE

(defun north (parent)
  (let ((x (get-0-x parent)) (y (get-0-y parent)) (child parent))
    (if (zero y) (return-from north nil))
    (setf child (grid-set x y child (grid-get x (- y 1) child)))
    (setf child (grid-set x (- y 1) child 0)) ;swap blank
    (setf child (grid-set 0 (- (length child) 1) child (- y 1))) ;update coords
    child))

(defun west (parent)
  (let ((x (get-0-x parent)) (y (get-0-y parent)) (child parent))
    (if (zero x) (return-from west nil))
    (setf child (grid-set x y child (grid-get (- x 1) y child)))
    (setf child (grid-set (- x 1) y child 0)) ;swap blank
    (setf child (grid-set 1 (- (length child) 1) child (- x 1))) ;update coords
    child))

(defun south (parent)
  (let ((x (get-0-x parent)) (y (get-0-y parent)) (child parent))
    (if (eq y (- (length child) 2)) (return-from south nil))
    (setf child (grid-set x y child (grid-get x (+ y 1) child)))
    (setf child (grid-set x (+ y 1) child 0)) ;swap blank
    (setf child (grid-set 0 (- (length child) 1) child (+ y 1))) ;update coords
    child))


(defun east (parent)
  (let ((x (get-0-x parent)) (y (get-0-y parent)) (child parent))
    (if (eq x (- (length (car child)) 1)) (return-from east nil))
    (setf child (grid-set x y child (grid-get (+ x 1) y child)))
    (setf child (grid-set (+ x 1) y child 0)) ;swap blank
    (setf child (grid-set 1 (- (length child) 1) child (+ x 1))) ;update coords
    child))
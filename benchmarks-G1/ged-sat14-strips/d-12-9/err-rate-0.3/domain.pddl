(define (domain genome-edit-distance)
  (:requirements :action-costs :equality)
  (:types
	object)
  (:constants )
  (:predicates
	(duplicate ?x - object ?y - object)
	(swappable ?x - object ?y - object)
	(cw ?x - object ?y - object)
	(free ?x - object)
	(gone ?x - object)
	(present ?x - object)
	(normal ?x - object)
	(inverted ?x - object)
	(idle )
	(cutting )
	(have-cut )
	(splicing )
	(splice-next ?x - object)
	(splicing-last )
	(inverse-splicing )
	(inverse-splice-next ?x - object)
	(inverse-splicing-last )
	(finished )
	(cut-point-1 ?x - object)
	(cut-point-2 ?x - object)
	(last-cut-point ?x - object)
	(splice-point-1 ?x - object)
	(splice-point-2 ?x - object)
	(s-first ?x - object)
	(s-next ?x - object ?y - object)
	(s-last ?x - object)
	(= ?x - object ?y - object))
  (:functions (total-cost ))
  (:action begin-cut
	:parameters (?x - object
		?y - object)
	:precondition (and
		(not (= ?x ?y))
		(idle )
		(cw ?x ?y))
	:effect (and
		(not (idle ))
		(cutting )
		(not (cw ?x ?y))
		(cut-point-1 ?x)
		(last-cut-point ?x)
		(s-first ?y)
		(s-last ?y)))

(:action continue-cut
	:parameters (?x - object
		?y - object)
	:precondition (and
		(not (= ?x ?y))
		(cutting )
		(s-last ?x)
		(cw ?x ?y))
	:effect (and
		(not (cw ?x ?y))
		(not (s-last ?x))
		(s-next ?x ?y)
		(s-last ?y)))

(:action end-cut-1
	:parameters (?x - object
		?y - object)
	:precondition (and
		(not (= ?x ?y))
		(cutting )
		(s-last ?x)
		(cw ?x ?y))
	:effect (and
		(not (cw ?x ?y))
		(cut-point-2 ?y)))

(:action end-cut-2
	:parameters (?x - object
		?y - object)
	:precondition (and
		(cutting )
		(cut-point-1 ?x)
		(cut-point-2 ?y)
		(have-cut ))
	:effect (and
		(not (cutting ))
		(not (cut-point-1 ?x))
		(not (cut-point-2 ?y))
		(have-cut )
		(cw ?x ?y)))

(:action begin-transpose-splice
	:parameters (?x - object
		?y - object)
	:precondition (and
		(not (= ?x ?y))
		(have-cut )
		(cw ?x ?y))
	:effect (and
		(not (have-cut ))
		(not (cw ?x ?y))
		(splicing )
		(splice-point-1 ?x)
		(splice-point-2 ?y)(increase (total-cost ) 2)))

(:action continue-splice-1
	:parameters (?x - object
		?y - object)
	:precondition (and
		(splicing )
		(s-first ?x)
		(s-next ?x ?y))
	:effect (and
		(not (s-first ?x))
		(not (s-next ?x ?y))
		(not (splicing ))
		(s-first ?y)
		(splice-next ?x)
		(present ?x)))

(:action continue-splice-2
	:parameters (?x - object
		?y - object)
	:precondition (and
		(splice-next ?x)
		(splice-point-1 ?y))
	:effect (and
		(not (splice-point-1 ?y))
		(not (splice-next ?x))
		(cw ?y ?x)
		(splice-point-1 ?x)
		(splicing )))

(:action end-splice-1
	:parameters (?x - object
		?y - object)
	:precondition (and
		(splicing )
		(splice-point-1 ?y)
		(s-first ?x)
		(s-last ?x))
	:effect (and
		(not (splicing ))
		(not (s-first ?x))
		(not (s-last ?x))
		(not (splice-point-1 ?y))
		(splicing-last )
		(cw ?y ?x)
		(splice-point-1 ?x)))

(:action end-splice-2
	:parameters (?x - object
		?y - object)
	:precondition (and
		(splicing-last )
		(splice-point-1 ?x)
		(splice-point-2 ?y))
	:effect (and
		(not (splicing-last ))
		(not (splice-point-1 ?x))
		(not (splice-point-2 ?y))
		(finished )
		(cw ?x ?y)))

(:action begin-transverse-splice
	:parameters (?x - object
		?y - object)
	:precondition (and
		(not (= ?x ?y))
		(have-cut )
		(cw ?x ?y))
	:effect (and
		(not (have-cut ))
		(not (cw ?x ?y))
		(inverse-splicing )
		(splice-point-1 ?x)
		(splice-point-2 ?y)
		(splice-point-1 ?y)(increase (total-cost ) 2)))

(:action begin-inverse-splice
	:parameters (?x - object
		?y - object)
	:precondition (and
		(not (= ?x ?y))
		(have-cut )
		(cw ?x ?y)
		(last-cut-point ?x))
	:effect (and
		(not (have-cut ))
		(not (cw ?x ?y))
		(inverse-splicing )
		(splice-point-2 ?y)(increase (total-cost ) 1)))

(:action begin-inverse-splice-special-case
	:parameters (?x - object)
	:precondition (and
		(have-cut )
		(cw ?x ?x)
		(last-cut-point ?x))
	:effect (and
		(not (have-cut ))
		(not (cw ?x ?x))
		(inverse-splicing )
		(splice-point-1 ?x)
		(splice-point-2 ?x)(increase (total-cost ) 1)))

(:action continue-inverse-splice-1a
	:parameters (?x - object
		?y - object)
	:precondition (and
		(inverse-splicing )
		(normal ?x)
		(s-last ?x)
		(s-next ?y ?x))
	:effect (and
		(not (s-last ?x))
		(not (s-next ?y ?x))
		(not (normal ?x))
		(s-last ?y)
		(not (inverse-splicing ))
		(inverse-splice-next ?x)
		(inverted ?x)))

(:action continue-inverse-splice-1b
	:parameters (?x - object
		?y - object)
	:precondition (and
		(inverse-splicing )
		(inverted ?x)
		(s-last ?x)
		(s-next ?y ?x))
	:effect (and
		(not (s-last ?x))
		(not (s-next ?y ?x))
		(not (inverted ?x))
		(s-last ?y)
		(not (inverse-splicing ))
		(inverse-splice-next ?x)
		(normal ?x)))

(:action continue-inverse-splice-2
	:parameters (?x - object
		?y - object)
	:precondition (and
		(inverse-splice-next ?x)
		(splice-point-1 ?y))
	:effect (and
		(not (inverse-splice-next ?x))
		(inverse-splicing )
		(cw ?y ?x)
		(splice-point-1 ?x)))

(:action end-inverse-splice-1a
	:parameters (?x - object
		?y - object)
	:precondition (and
		(inverse-splicing )
		(normal ?x)
		(splice-point-1 ?y)
		(s-first ?x)
		(s-last ?x))
	:effect (and
		(not (inverse-splicing ))
		(inverse-splicing-last )
		(not (splice-point-1 ?y))
		(not (s-first ?x))
		(not (s-last ?x))
		(not (normal ?x))
		(cw ?y ?x)
		(splice-point-1 ?x)
		(inverted ?x)
		(have-cut )))

(:action end-inverse-splice-1b
	:parameters (?x - object
		?y - object)
	:precondition (and
		(inverse-splicing )
		(inverted ?x)
		(splice-point-1 ?y)
		(s-first ?x)
		(s-last ?x))
	:effect (and
		(not (inverse-splicing ))
		(inverse-splicing-last )
		(not (splice-point-1 ?y))
		(not (s-first ?x))
		(not (s-last ?x))
		(not (inverted ?x))
		(cw ?y ?x)
		(splice-point-1 ?x)
		(normal ?x)))

(:action end-inverse-splice-2
	:parameters (?x - object
		?y - object)
	:precondition (and
		(inverse-splicing-last )
		(splice-point-1 ?x)
		(splice-point-2 ?y))
	:effect (and
		(not (inverse-splicing-last ))
		(not (splice-point-1 ?x))
		(not (splice-point-2 ?y))
		(finished )
		(cw ?x ?y)))

(:action invert-single-gene-a
	:parameters (?x - object)
	:precondition (and
		(idle )
		(normal ?x))
	:effect (and
		(not (normal ?x))
		(inverted ?x)(increase (total-cost ) 1)))

(:action invert-single-gene-b
	:parameters (?x - object)
	:precondition (and
		(idle )
		(inverted ?x))
	:effect (and
		(not (inverted ?x))
		(normal ?x)(increase (total-cost ) 1)))

(:action reset-1
	:parameters (?x - object)
	:precondition (and
		(finished )
		(last-cut-point ?x))
	:effect (and
		(not (last-cut-point ?x))
		(not (finished ))
		(idle )
		(splicing ))) )
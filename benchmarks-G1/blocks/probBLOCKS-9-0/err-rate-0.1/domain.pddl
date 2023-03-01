(define (domain blocks)
  (:requirements :strips)
  (:types
	object)
  (:constants )
  (:predicates
	(on ?x - object ?y - object)
	(ontable ?x - object)
	(clear ?x - object)
	(handempty )
	(holding ?x - object)
	(= ?x - object ?y - object))
  (:functions )
  (:action pick-up
	:parameters (?x - object)
	:precondition (and
		(clear ?x)
		(ontable ?x)
		(handempty ))
	:effect (and
		(not (ontable ?x))
		(not (clear ?x))
		(not (handempty ))
		(holding ?x)))

(:action put-down
	:parameters (?x - object)
	:precondition (holding ?x)
	:effect (and
		(not (holding ?x))
		(clear ?x)
		(handempty )
		(ontable ?x)))

(:action stack
	:parameters (?x - object
		?y - object)
	:precondition (and
		(holding ?x)
		(clear ?y))
	:effect (and
		(not (holding ?x))
		(not (clear ?y))
		(clear ?x)
		(handempty )))

(:action unstack
	:parameters (?x - object
		?y - object)
	:precondition (and
		(on ?x ?y)
		(clear ?x)
		(handempty ))
	:effect (and
		(holding ?x)
		(clear ?y)
		(not (clear ?x))
		(not (handempty ))
		(not (on ?x ?y)))) )
(define (domain grid-visit-all)
  (:requirements :typing)
  (:types object
	object - object
	place - object)
  (:constants )
  (:predicates (connected ?x - place ?y - place)
	(at-robot ?x - place)
	(visited ?x - place)
	(= ?x - object ?y - object)
	(= ?x - object ?y - object))
  (:functions )
  (:action move
	:parameters (?curpos - place
		?nextpos - place)
	:precondition (and
		(connected ?curpos ?nextpos))
	:effect (and
		(not (at-robot ?curpos))
		(visited ?nextpos))))
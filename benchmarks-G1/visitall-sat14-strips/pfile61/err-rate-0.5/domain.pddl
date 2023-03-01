(define (domain grid-visit-all)
  (:requirements :typing)
  (:types
	object
	place - object)
  (:constants )
  (:predicates
	(connected ?x - place ?y - place)
	(at-robot ?x - place)
	(visited ?x - place)
	(= ?x - object ?y - object))
  (:functions )
  (:action move
	:parameters (?curpos - place
		?nextpos - place)
	:precondition (and
		(at-robot ?curpos)
		(connected ?curpos ?nextpos))
	:effect (and
		(at-robot ?nextpos)
		(not (at-robot ?curpos))
		(visited ?nextpos)
		(not (connected ?nextpos ?nextpos)))) )
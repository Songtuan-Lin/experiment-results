(define (domain transport)
  (:requirements :action-costs :typing)
  (:types
	object
	location - object
	target - object
	locatable - object
	vehicle - locatable
	package - locatable
	capacity-number - object)
  (:constants )
  (:predicates
	(road ?l1 - location ?l2 - location)
	(at ?x - locatable ?v - location)
	(in ?x - package ?v - vehicle)
	(capacity ?v - vehicle ?s1 - capacity-number)
	(capacity-predecessor ?s1 - capacity-number ?s2 - capacity-number)
	(= ?x - object ?y - object))
  (:functions (road-length ?l1 - location - ?l2 - location)
	(total-cost ))
  (:action drive
	:parameters (?v - vehicle
		?l1 - location
		?l2 - location)
	:precondition (and
		(at ?v ?l1)
		(road ?l1 ?l2))
	:effect (and
		(not (at ?v ?l1))
		(at ?v ?l2)
		(not (road ?l2 ?l1))(increase (total-cost ) (road-length ?l1 ?l2))))

(:action pick-up
	:parameters (?v - vehicle
		?l - location
		?p - package
		?s1 - capacity-number
		?s2 - capacity-number)
	:precondition (and
		(at ?v ?l)
		(at ?p ?l)
		(capacity-predecessor ?s1 ?s2)
		(capacity ?v ?s2))
	:effect (and
		(not (at ?p ?l))
		(in ?p ?v)
		(capacity ?v ?s1)
		(not (capacity ?v ?s2))
		(not (capacity-predecessor ?s2 ?s1))(increase (total-cost ) 1)))

(:action drop
	:parameters (?v - vehicle
		?l - location
		?p - package
		?s1 - capacity-number
		?s2 - capacity-number)
	:precondition (and
		(at ?v ?l)
		(in ?p ?v)
		(capacity-predecessor ?s1 ?s2)
		(capacity ?v ?s1))
	:effect (and
		(not (in ?p ?v))
		(at ?p ?l)
		(capacity ?v ?s2)
		(not (capacity ?v ?s1))(increase (total-cost ) 1))) )
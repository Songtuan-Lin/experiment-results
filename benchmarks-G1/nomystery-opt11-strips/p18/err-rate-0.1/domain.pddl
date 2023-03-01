(define (domain transport-strips)
  (:requirements :action-costs :typing)
  (:types
	object
	location - object
	fuellevel - object
	locatable - object
	package - locatable
	truck - locatable)
  (:constants )
  (:predicates
	(connected ?l1 - location ?l2 - location)
	(at ?o - locatable ?l - location)
	(in ?p - package ?t - truck)
	(fuel ?t - truck ?level - fuellevel)
	(fuelcost ?level - fuellevel ?l1 - location ?l2 - location)
	(sum ?a - fuellevel ?b - fuellevel ?c - fuellevel)
	(= ?x - object ?y - object))
  (:functions (total-cost ))
  (:action load
	:parameters (?p - package
		?t - truck
		?l - location)
	:precondition (and
		(at ?t ?l)
		(at ?p ?l))
	:effect (and
		(not (at ?p ?l))
		(in ?p ?t)(increase (total-cost ) 1)))

(:action unload
	:parameters (?p - package
		?t - truck
		?l - location)
	:precondition (and
		(at ?t ?l)
		(in ?p ?t))
	:effect (and
		(at ?p ?l)
		(not (in ?p ?t))(increase (total-cost ) 1)))

(:action drive
	:parameters (?t - truck
		?l1 - location
		?l2 - location
		?fuelpost - fuellevel
		?fueldelta - fuellevel
		?fuelpre - fuellevel)
	:precondition (and
		(connected ?l1 ?l2)
		(fuelcost ?fueldelta ?l1 ?l2)
		(fuel ?t ?fuelpre)
		(sum ?fuelpost ?fueldelta ?fuelpre)
		(at ?t ?l1))
	:effect (and
		(not (at ?t ?l1))
		(at ?t ?l2)
		(not (fuel ?t ?fuelpre))
		(fuel ?t ?fuelpost)
		(not (fuelcost ?fuelpre ?l2 ?l1))(increase (total-cost ) 1))) )
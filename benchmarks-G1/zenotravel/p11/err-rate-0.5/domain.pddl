(define (domain zeno-travel)
  (:requirements :strips)
  (:types
	object)
  (:constants )
  (:predicates
	(at ?x - object ?c - object)
	(in ?p - object ?a - object)
	(fuel-level ?a - object ?l - object)
	(next ?l1 - object ?l2 - object)
	(aircraft ?p - object)
	(person ?x - object)
	(city ?x - object)
	(flevel ?x - object)
	(= ?x - object ?y - object))
  (:functions )
  (:action board
	:parameters (?p - object
		?a - object
		?c - object)
	:precondition (and
		(person ?p)
		(aircraft ?a)
		(city ?c)
		(at ?p ?c)
		(at ?a ?c))
	:effect (and
		(in ?p ?a)
		(not (at ?p ?c))))

(:action debark
	:parameters (?p - object
		?a - object
		?c - object)
	:precondition (and
		(person ?p)
		(aircraft ?a)
		(city ?c)
		(in ?p ?a)
		(at ?a ?c)
		(city ?c))
	:effect (and
		(at ?p ?c)
		(not (in ?p ?a))))

(:action fly
	:parameters (?a - object
		?c1 - object
		?c2 - object
		?l1 - object
		?l2 - object)
	:precondition (and
		(aircraft ?a)
		(city ?c1)
		(city ?c2)
		(flevel ?l1)
		(flevel ?l2)
		(at ?a ?c1)
		(fuel-level ?a ?l1)
		(next ?l2 ?l1)
		(in ?l2 ?l1))
	:effect (and
		(at ?a ?c2)
		(fuel-level ?a ?l2)
		(not (at ?a ?c1))
		(not (fuel-level ?a ?l1))))

(:action zoom
	:parameters (?a - object
		?c1 - object
		?c2 - object
		?l1 - object
		?l2 - object
		?l3 - object)
	:precondition (and
		(aircraft ?a)
		(city ?c1)
		(city ?c2)
		(flevel ?l1)
		(flevel ?l2)
		(flevel ?l3)
		(at ?a ?c1)
		(fuel-level ?a ?l1)
		(next ?l2 ?l1)
		(next ?l3 ?l2))
	:effect (and
		(at ?a ?c2)
		(fuel-level ?a ?l3)
		(not (at ?a ?c1))
		(not (fuel-level ?a ?l1))))

(:action refuel
	:parameters (?a - object
		?c - object
		?l - object
		?l1 - object)
	:precondition (and
		(aircraft ?a)
		(city ?c)
		(flevel ?l)
		(flevel ?l1)
		(fuel-level ?a ?l)
		(next ?l ?l1)
		(at ?a ?c)
		(in ?a ?a))
	:effect (and
		(fuel-level ?a ?l1)
		(not (fuel-level ?a ?l)))) )
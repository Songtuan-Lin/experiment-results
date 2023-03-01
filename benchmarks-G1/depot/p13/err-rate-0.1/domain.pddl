(define (domain depot)
  (:requirements :strips)
  (:types
	object)
  (:constants )
  (:predicates
	(at ?x - object ?y - object)
	(on ?x - object ?y - object)
	(in ?x - object ?y - object)
	(lifting ?x - object ?y - object)
	(available ?x - object)
	(clear ?x - object)
	(place ?x - object)
	(locatable ?x - object)
	(depot ?x - object)
	(distributor ?x - object)
	(truck ?x - object)
	(hoist ?x - object)
	(surface ?x - object)
	(pallet ?x - object)
	(crate ?x - object)
	(= ?x - object ?y - object))
  (:functions )
  (:action drive
	:parameters (?x - object
		?y - object
		?z - object)
	:precondition (and
		(truck ?x)
		(place ?y)
		(place ?z)
		(at ?x ?y))
	:effect (and
		(at ?x ?z)
		(not (at ?x ?y))))

(:action lift
	:parameters (?x - object
		?y - object
		?z - object
		?p - object)
	:precondition (and
		(hoist ?x)
		(crate ?y)
		(surface ?z)
		(place ?p)
		(at ?x ?p)
		(available ?x)
		(at ?y ?p)
		(on ?y ?z)
		(clear ?y)
		(lifting ?p ?p))
	:effect (and
		(lifting ?x ?y)
		(clear ?z)
		(not (at ?y ?p))
		(not (clear ?y))
		(not (available ?x))
		(not (on ?y ?z))))

(:action drop
	:parameters (?x - object
		?y - object
		?z - object
		?p - object)
	:precondition (and
		(hoist ?x)
		(crate ?y)
		(surface ?z)
		(place ?p)
		(at ?x ?p)
		(at ?z ?p)
		(clear ?z)
		(lifting ?x ?y))
	:effect (and
		(available ?x)
		(at ?y ?p)
		(clear ?y)
		(on ?y ?z)
		(not (lifting ?x ?y))
		(not (clear ?z))))

(:action load
	:parameters (?x - object
		?y - object
		?z - object
		?p - object)
	:precondition (and
		(hoist ?x)
		(crate ?y)
		(truck ?z)
		(place ?p)
		(at ?x ?p)
		(at ?z ?p)
		(lifting ?x ?y))
	:effect (and
		(in ?y ?z)
		(available ?x)
		(not (lifting ?x ?y))))

(:action unload
	:parameters (?x - object
		?y - object
		?z - object
		?p - object)
	:precondition (and
		(hoist ?x)
		(crate ?y)
		(truck ?z)
		(place ?p)
		(at ?x ?p)
		(at ?z ?p)
		(available ?x)
		(in ?y ?z))
	:effect (and
		(lifting ?x ?y)
		(not (in ?y ?z))
		(not (available ?x)))) )
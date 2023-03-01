(define (domain logistics-strips)
  (:requirements :strips)
  (:types
	object)
  (:constants )
  (:predicates
	(obj ?obj - object)
	(truck ?truck - object)
	(location ?loc - object)
	(airplane ?airplane - object)
	(city ?city - object)
	(airport ?airport - object)
	(at ?obj - object ?loc - object)
	(in ?obj1 - object ?obj2 - object)
	(in-city ?obj - object ?city - object)
	(= ?x - object ?y - object))
  (:functions )
  (:action load-truck
	:parameters (?obj - object
		?truck - object
		?loc - object)
	:precondition (and
		(obj ?obj)
		(truck ?truck)
		(location ?loc)
		(at ?truck ?loc)
		(at ?obj ?loc))
	:effect (and
		(not (at ?obj ?loc))
		(in ?obj ?truck)))

(:action load-airplane
	:parameters (?obj - object
		?airplane - object
		?loc - object)
	:precondition (and
		(obj ?obj)
		(airplane ?airplane)
		(location ?loc)
		(at ?obj ?loc)
		(at ?airplane ?loc))
	:effect (and
		(not (at ?obj ?loc))
		(in ?obj ?airplane)
		(not (location ?obj))))

(:action unload-truck
	:parameters (?obj - object
		?truck - object
		?loc - object)
	:precondition (and
		(obj ?obj)
		(truck ?truck)
		(location ?loc)
		(at ?truck ?loc)
		(in ?obj ?truck))
	:effect (and
		(not (in ?obj ?truck))
		(at ?obj ?loc)
		(not (airplane ?obj))))

(:action unload-airplane
	:parameters (?obj - object
		?airplane - object
		?loc - object)
	:precondition (and
		(obj ?obj)
		(airplane ?airplane)
		(location ?loc)
		(in ?obj ?airplane)
		(at ?airplane ?loc))
	:effect (and
		(not (in ?obj ?airplane))
		(at ?obj ?loc)
		(not (at ?obj ?airplane))))

(:action drive-truck
	:parameters (?truck - object
		?loc-from - object
		?loc-to - object
		?city - object)
	:precondition (and
		(truck ?truck)
		(location ?loc-from)
		(location ?loc-to)
		(city ?city)
		(at ?truck ?loc-from)
		(in-city ?loc-from ?city)
		(in-city ?loc-to ?city))
	:effect (and
		(not (at ?truck ?loc-from))
		(at ?truck ?loc-to)))

(:action fly-airplane
	:parameters (?airplane - object
		?loc-from - object
		?loc-to - object)
	:precondition (and
		(airplane ?airplane)
		(airport ?loc-from)
		(airport ?loc-to)
		(at ?airplane ?loc-from))
	:effect (and
		(not (at ?airplane ?loc-from))
		(at ?airplane ?loc-to))) )
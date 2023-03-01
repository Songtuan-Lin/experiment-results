(define (domain logistics)
  (:requirements :strips)
  (:types
	object)
  (:constants )
  (:predicates
	(package ?obj - object)
	(truck ?truck - object)
	(airplane ?airplane - object)
	(airport ?airport - object)
	(location ?loc - object)
	(in-city ?obj - object ?city - object)
	(city ?city - object)
	(at ?obj - object ?loc - object)
	(in ?obj - object ?obj - object)
	(= ?x - object ?y - object))
  (:functions )
  (:action load-truck
	:parameters (?obj - object
		?truck - object
		?loc - object)
	:precondition (and
		(package ?obj)
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
		(package ?obj)
		(airplane ?airplane)
		(location ?loc)
		(at ?obj ?loc)
		(at ?airplane ?loc))
	:effect (and
		(not (at ?obj ?loc))
		(in ?obj ?airplane)))

(:action unload-truck
	:parameters (?obj - object
		?truck - object
		?loc - object)
	:precondition (and
		(package ?obj)
		(truck ?truck)
		(location ?loc)
		(at ?truck ?loc)
		(in ?obj ?truck))
	:effect (and
		(not (in ?obj ?truck))
		(at ?obj ?loc)
		(not (at ?loc ?obj))))

(:action unload-airplane
	:parameters (?obj - object
		?airplane - object
		?loc - object)
	:precondition (and
		(package ?obj)
		(airplane ?airplane)
		(location ?loc)
		(in ?obj ?airplane)
		(at ?airplane ?loc))
	:effect (and
		(not (in ?obj ?airplane))
		(at ?obj ?loc)))

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
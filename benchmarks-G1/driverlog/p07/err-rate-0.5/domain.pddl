(define (domain driverlog)
  (:requirements :strips)
  (:types
	object)
  (:constants )
  (:predicates
	(obj ?obj - object)
	(truck ?truck - object)
	(location ?loc - object)
	(driver ?d - object)
	(at ?obj - object ?loc - object)
	(in ?obj1 - object ?obj - object)
	(driving ?d - object ?v - object)
	(link ?x - object ?y - object)
	(path ?x - object ?y - object)
	(empty ?v - object)
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
		(not (in ?obj ?truck))))

(:action board-truck
	:parameters (?driver - object
		?truck - object
		?loc - object)
	:precondition (and
		(driver ?driver)
		(truck ?truck)
		(location ?loc)
		(at ?truck ?loc)
		(at ?driver ?loc)
		(empty ?truck))
	:effect (and
		(not (at ?driver ?loc))
		(not (empty ?truck))))

(:action disembark-truck
	:parameters (?driver - object
		?truck - object
		?loc - object)
	:precondition (and
		(driver ?driver)
		(truck ?truck)
		(location ?loc)
		(at ?truck ?loc)
		(driving ?driver ?truck))
	:effect (and
		(not (driving ?driver ?truck))
		(at ?driver ?loc)
		(empty ?truck)))

(:action drive-truck
	:parameters (?truck - object
		?loc-from - object
		?loc-to - object
		?driver - object)
	:precondition (and
		(truck ?truck)
		(location ?loc-from)
		(location ?loc-to)
		(driver ?driver)
		(at ?truck ?loc-from)
		(driving ?driver ?truck)
		(link ?loc-from ?loc-to))
	:effect (and
		(not (at ?truck ?loc-from))
		(at ?truck ?loc-to)))

(:action walk
	:parameters (?driver - object
		?loc-from - object
		?loc-to - object)
	:precondition (and
		(driver ?driver)
		(location ?loc-from)
		(location ?loc-to)
		(at ?driver ?loc-from)
		(path ?loc-from ?loc-to))
	:effect (and
		(not (at ?driver ?loc-from)))) )
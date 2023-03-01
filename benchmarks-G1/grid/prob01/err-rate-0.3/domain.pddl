(define (domain grid)
  (:requirements :strips)
  (:types
	object)
  (:constants )
  (:predicates
	(conn ?x - object ?y - object)
	(key-shape ?k - object ?s - object)
	(lock-shape ?x - object ?s - object)
	(at ?r - object ?x - object)
	(at-robot ?x - object)
	(place ?p - object)
	(key ?k - object)
	(shape ?s - object)
	(locked ?x - object)
	(holding ?k - object)
	(open ?x - object)
	(arm-empty )
	(= ?x - object ?y - object))
  (:functions )
  (:action unlock
	:parameters (?curpos - object
		?lockpos - object
		?key - object
		?shape - object)
	:precondition (and
		(place ?curpos)
		(place ?lockpos)
		(key ?key)
		(shape ?shape)
		(conn ?curpos ?lockpos)
		(key-shape ?key ?shape)
		(lock-shape ?lockpos ?shape)
		(at-robot ?curpos)
		(locked ?lockpos)
		(holding ?key)
		(lock-shape ?lockpos ?lockpos))
	:effect (and
		(open ?lockpos)
		(not (locked ?lockpos))))

(:action move
	:parameters (?curpos - object
		?nextpos - object)
	:precondition (and
		(place ?curpos)
		(place ?nextpos)
		(at-robot ?curpos)
		(conn ?curpos ?nextpos)
		(open ?nextpos))
	:effect (and
		(at-robot ?nextpos)
		(not (at-robot ?curpos))))

(:action pickup
	:parameters (?curpos - object
		?key - object)
	:precondition (and
		(place ?curpos)
		(key ?key)
		(at-robot ?curpos)
		(at ?key ?curpos)
		(arm-empty )
		(key ?curpos))
	:effect (and
		(holding ?key)
		(not (at ?key ?curpos))
		(not (arm-empty ))))

(:action pickup-and-loose
	:parameters (?curpos - object
		?newkey - object
		?oldkey - object)
	:precondition (and
		(place ?curpos)
		(key ?newkey)
		(key ?oldkey)
		(at-robot ?curpos)
		(holding ?oldkey)
		(at ?newkey ?curpos))
	:effect (and
		(holding ?newkey)
		(at ?oldkey ?curpos)
		(not (holding ?oldkey))
		(not (at ?newkey ?curpos))))

(:action putdown
	:parameters (?curpos - object
		?key - object)
	:precondition (and
		(place ?curpos)
		(key ?key)
		(at-robot ?curpos)
		(holding ?key))
	:effect (and
		(arm-empty )
		(at ?key ?curpos)
		(not (holding ?key)))) )
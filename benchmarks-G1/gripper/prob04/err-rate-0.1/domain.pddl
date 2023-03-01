(define (domain gripper-strips)
  (:requirements :strips)
  (:types
	object)
  (:constants )
  (:predicates
	(room ?r - object)
	(ball ?b - object)
	(gripper ?g - object)
	(at-robby ?r - object)
	(at ?b - object ?r - object)
	(free ?g - object)
	(carry ?o - object ?g - object)
	(= ?x - object ?y - object))
  (:functions )
  (:action move
	:parameters (?from - object
		?to - object)
	:precondition (and
		(room ?from)
		(room ?to)
		(at-robby ?from))
	:effect (and
		(at-robby ?to)
		(not (at-robby ?from))))

(:action pick
	:parameters (?obj - object
		?room - object
		?gripper - object)
	:precondition (and
		(ball ?obj)
		(room ?room)
		(gripper ?gripper)
		(at ?obj ?room)
		(at-robby ?room)
		(free ?gripper))
	:effect (and
		(carry ?obj ?gripper)
		(not (at ?obj ?room))
		(not (free ?gripper))
		(not (carry ?obj ?room))))

(:action drop
	:parameters (?obj - object
		?room - object
		?gripper - object)
	:precondition (and
		(ball ?obj)
		(room ?room)
		(gripper ?gripper)
		(carry ?obj ?gripper)
		(at-robby ?room))
	:effect (and
		(at ?obj ?room)
		(free ?gripper)
		(not (carry ?obj ?gripper)))) )
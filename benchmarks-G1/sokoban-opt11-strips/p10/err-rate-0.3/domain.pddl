(define (domain sokoban-sequential)
  (:requirements :action-costs :typing)
  (:types
	object
	thing - object
	location - object
	direction - object
	player - thing
	stone - thing)
  (:constants )
  (:predicates
	(clear ?l - location)
	(at ?t - thing ?l - location)
	(at-goal ?s - stone)
	(is-goal ?l - location)
	(is-nongoal ?l - location)
	(move-dir ?from - location ?to - location ?dir - direction)
	(= ?x - object ?y - object))
  (:functions (total-cost ))
  (:action move
	:parameters (?p - player
		?from - location
		?to - location
		?dir - direction)
	:precondition (and
		(at ?p ?from)
		(clear ?to)
		(move-dir ?from ?to ?dir))
	:effect (and
		(not (at ?p ?from))
		(not (clear ?to))
		(at ?p ?to)
		(clear ?from)))

(:action push-to-nongoal
	:parameters (?p - player
		?s - stone
		?ppos - location
		?from - location
		?to - location
		?dir - direction)
	:precondition (and
		(at ?p ?ppos)
		(at ?s ?from)
		(clear ?to)
		(move-dir ?ppos ?from ?dir)
		(move-dir ?from ?to ?dir)
		(is-nongoal ?to))
	:effect (and
		(not (at ?p ?ppos))
		(not (at ?s ?from))
		(not (clear ?to))
		(at ?p ?from)
		(at ?s ?to)
		(not (at-goal ?s))(increase (total-cost ) 1)))

(:action push-to-goal
	:parameters (?p - player
		?s - stone
		?ppos - location
		?from - location
		?to - location
		?dir - direction)
	:precondition (and
		(at ?p ?ppos)
		(at ?s ?from)
		(clear ?to)
		(move-dir ?ppos ?from ?dir)
		(move-dir ?from ?to ?dir)
		(is-goal ?to))
	:effect (and
		(not (at ?p ?ppos))
		(not (at ?s ?from))
		(not (clear ?to))
		(at ?p ?from)
		(at ?s ?to)
		(clear ?ppos)
		(at-goal ?s)(increase (total-cost ) 1))) )
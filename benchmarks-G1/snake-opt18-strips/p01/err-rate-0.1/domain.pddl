(define (domain snake)
  (:requirements :negative-preconditions :strips)
  (:types
	object)
  (:constants dummypoint - object)
  (:predicates
	(isadjacent ?x - object ?y - object)
	(tailsnake ?x - object)
	(headsnake ?x - object)
	(nextsnake ?x - object ?y - object)
	(blocked ?x - object)
	(spawn ?x - object)
	(nextspawn ?x - object ?y - object)
	(ispoint ?x - object)
	(= ?x - object ?y - object))
  (:functions )
  (:action move
	:parameters (?head - object
		?newhead - object
		?tail - object
		?newtail - object)
	:precondition (and
		(headsnake ?head)
		(isadjacent ?head ?newhead)
		(tailsnake ?tail)
		(nextsnake ?newtail ?tail)
		(not (blocked ?newhead))
		(not (ispoint ?newhead)))
	:effect (and
		(blocked ?newhead)
		(headsnake ?newhead)
		(nextsnake ?newhead ?head)
		(not (headsnake ?head))
		(not (blocked ?tail))
		(not (tailsnake ?tail))
		(not (nextsnake ?newtail ?tail))
		(tailsnake ?newtail)))

(:action move-and-eat-spawn
	:parameters (?head - object
		?newhead - object
		?spawnpoint - object
		?nextspawnpoint - object)
	:precondition (and
		(headsnake ?head)
		(isadjacent ?head ?newhead)
		(not (blocked ?newhead))
		(ispoint ?newhead)
		(spawn ?spawnpoint)
		(nextspawn ?spawnpoint ?nextspawnpoint)
		(not (= ?spawnpoint dummypoint)))
	:effect (and
		(blocked ?newhead)
		(headsnake ?newhead)
		(nextsnake ?newhead ?head)
		(not (headsnake ?head))
		(not (ispoint ?newhead))
		(ispoint ?spawnpoint)
		(not (spawn ?spawnpoint))
		(spawn ?nextspawnpoint)
		(not (= ?nextspawnpoint ?nextspawnpoint))))

(:action move-and-eat-no-spawn
	:parameters (?head - object
		?newhead - object)
	:precondition (and
		(headsnake ?head)
		(isadjacent ?head ?newhead)
		(not (blocked ?newhead))
		(ispoint ?newhead)
		(spawn dummypoint))
	:effect (and
		(blocked ?newhead)
		(headsnake ?newhead)
		(nextsnake ?newhead ?head)
		(not (headsnake ?head))
		(not (ispoint ?newhead)))) )
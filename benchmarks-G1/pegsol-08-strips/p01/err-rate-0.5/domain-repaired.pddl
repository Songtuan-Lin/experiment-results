(define (domain pegsolitaire-sequential)
  (:requirements :action-costs :typing)
  (:types object
	object - object
	location - object)
  (:constants )
  (:predicates (in-line ?x - location ?y - location ?z - location)
	(occupied ?l - location)
	(free ?l - location)
	(move-ended )
	(last-visited ?l - location)
	(= ?x - object ?y - object)
	(= ?x - object ?y - object))
  (:functions (total-cost) - number)
  (:action jump-new-move
	:parameters (?from - location
		?over - location
		?to - location)
	:precondition (and
		(move-ended )
		(in-line ?from ?over ?to)
		(occupied ?from)
		(occupied ?over)
		(free ?to))
	:effect (and
		(not (move-ended ))
		(not (occupied ?from))
		(not (occupied ?over))
		(not (free ?to))
		(free ?from)
		(free ?over)
		(occupied ?to)
		(last-visited ?to)
		(not (in-line ?over ?over ?over))(increase (total-cost ) 1)))

  (:action jump-continue-move
	:parameters (?from - location
		?over - location
		?to - location)
	:precondition (and
		(last-visited ?from)
		(in-line ?from ?over ?to)
		(occupied ?from)
		(occupied ?over)
		(free ?to))
	:effect (and
		(not (occupied ?from))
		(not (occupied ?over))
		(not (free ?to))
		(free ?from)
		(free ?over)
		(occupied ?to)
		(not (last-visited ?from))
		(last-visited ?to)))

  (:action end-move
	:parameters (?loc - location)
	:precondition (last-visited ?loc)
	:effect (and
		(move-ended )
		(not (last-visited ?loc))
		(not (in-line ?loc ?loc ?loc)))))
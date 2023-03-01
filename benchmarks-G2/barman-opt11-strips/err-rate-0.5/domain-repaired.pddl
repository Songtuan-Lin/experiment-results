(define (domain barman)
  (:requirements :action-costs :strips :typing)
  (:types object
	object - object
	hand - object
	level - object
	beverage - object
	dispenser - object
	container - object
	ingredient - beverage
	cocktail - beverage
	shot - container
	shaker - container)
  (:constants )
  (:predicates (ontable ?c - container)
	(holding ?h - hand ?c - container)
	(handempty ?h - hand)
	(empty ?c - container)
	(contains ?c - container ?b - beverage)
	(clean ?c - container)
	(used ?c - container ?b - beverage)
	(dispenses ?d - dispenser ?i - ingredient)
	(shaker-empty-level ?s - shaker ?l - level)
	(shaker-level ?s - shaker ?l - level)
	(next ?l1 - level ?l2 - level)
	(unshaked ?s - shaker)
	(shaked ?s - shaker)
	(cocktail-part1 ?c - cocktail ?i - ingredient)
	(cocktail-part2 ?c - cocktail ?i - ingredient)
	(= ?x - object ?y - object)
	(= ?x - object ?y - object))
  (:functions (total-cost) - number)
  (:action grasp
	:parameters (?h - hand
		?c - container)
	:precondition (and
		(ontable ?c)
		(handempty ?h))
	:effect (and
		(not (ontable ?c))
		(not (handempty ?h))
		(holding ?h ?c)(increase (total-cost ) 1)))

  (:action leave
	:parameters (?h - hand
		?c - container)
	:precondition (holding ?h ?c)
	:effect (and
		(not (holding ?h ?c))
		(handempty ?h)
		(ontable ?c)
		(not (empty ?c))
		(empty ?c)(increase (total-cost ) 1)))

  (:action fill-shot
	:parameters (?s - shot
		?i - ingredient
		?h1 - hand
		?h2 - hand
		?d - dispenser)
	:precondition (and
		(holding ?h1 ?s)
		(handempty ?h2)
		(dispenses ?d ?i)
		(empty ?s)
		(clean ?s))
	:effect (and
		(not (empty ?s))
		(contains ?s ?i)
		(not (clean ?s))
		(used ?s ?i)(increase (total-cost ) 10)))

  (:action refill-shot
	:parameters (?s - shot
		?i - ingredient
		?h1 - hand
		?h2 - hand
		?d - dispenser)
	:precondition (and
		(holding ?h1 ?s)
		(handempty ?h2)
		(dispenses ?d ?i)
		(empty ?s)
		(used ?s ?i))
	:effect (and
		(not (empty ?s))
		(contains ?s ?i)(increase (total-cost ) 10)))

  (:action empty-shot
	:parameters (?h - hand
		?p - shot
		?b - beverage)
	:precondition (and
		(holding ?h ?p)
		(contains ?p ?b))
	:effect (and
		(not (contains ?p ?b))(increase (total-cost ) 1)))

  (:action clean-shot
	:parameters (?s - shot
		?b - beverage
		?h1 - hand
		?h2 - hand)
	:precondition (and
		(holding ?h1 ?s)
		(handempty ?h2)
		(empty ?s)
		(used ?s ?b))
	:effect (and
		(not (used ?s ?b))
		(clean ?s)(increase (total-cost ) 1)))

  (:action pour-shot-to-clean-shaker
	:parameters (?s - shot
		?i - ingredient
		?d - shaker
		?h1 - hand
		?l - level
		?l1 - level)
	:precondition (and
		(holding ?h1 ?s)
		(contains ?s ?i)
		(empty ?d)
		(clean ?d)
		(shaker-level ?d ?l)
		(next ?l ?l1))
	:effect (and
		(not (contains ?s ?i))
		(empty ?s)
		(contains ?d ?i)
		(not (empty ?d))
		(not (clean ?d))
		(unshaked ?d)
		(not (shaker-level ?d ?l))
		(shaker-level ?d ?l1)(increase (total-cost ) 1)))

  (:action pour-shot-to-used-shaker
	:parameters (?s - shot
		?i - ingredient
		?d - shaker
		?h1 - hand
		?l - level
		?l1 - level)
	:precondition (and
		(holding ?h1 ?s)
		(contains ?s ?i)
		(unshaked ?d)
		(shaker-level ?d ?l)
		(next ?l ?l1))
	:effect (and
		(not (contains ?s ?i))
		(contains ?d ?i)
		(empty ?s)
		(not (shaker-level ?d ?l))
		(shaker-level ?d ?l1)(increase (total-cost ) 1)))

  (:action empty-shaker
	:parameters (?h - hand
		?s - shaker
		?b - cocktail
		?l - level
		?l1 - level)
	:precondition (and
		(holding ?h ?s)
		(contains ?s ?b)
		(shaked ?s)
		(shaker-level ?s ?l)
		(shaker-empty-level ?s ?l1))
	:effect (and
		(not (shaker-level ?s ?l))
		(shaker-level ?s ?l1)
		(not (contains ?s ?b))
		(empty ?s)(increase (total-cost ) 1)))

  (:action clean-shaker
	:parameters (?h1 - hand
		?h2 - hand
		?s - shaker)
	:precondition (and
		(holding ?h1 ?s)
		(handempty ?h2)
		(empty ?s)
		(shaked ?s))
	:effect (and
		(clean ?s)(increase (total-cost ) 1)))

  (:action shake
	:parameters (?b - cocktail
		?d1 - ingredient
		?d2 - ingredient
		?s - shaker
		?h1 - hand
		?h2 - hand)
	:precondition (and
		(holding ?h1 ?s)
		(handempty ?h2)
		(contains ?s ?d1)
		(contains ?s ?d2)
		(cocktail-part1 ?b ?d1)
		(cocktail-part2 ?b ?d2)
		(unshaked ?s))
	:effect (and
		(not (contains ?s ?d1))
		(not (contains ?s ?d2))
		(shaked ?s)
		(contains ?s ?b)
		(not (cocktail-part1 ?b ?d1))(increase (total-cost ) 1)))

  (:action pour-shaker-to-shot
	:parameters (?b - beverage
		?d - shot
		?h - hand
		?s - shaker
		?l - level
		?l1 - level)
	:precondition (and
		(holding ?h ?s)
		(shaked ?s)
		(empty ?d)
		(clean ?d)
		(contains ?s ?b)
		(shaker-level ?s ?l)
		(next ?l1 ?l)
		(unshaked ?s))
	:effect (and
		(not (clean ?d))
		(not (empty ?d))
		(contains ?d ?b)
		(shaker-level ?s ?l1)
		(not (shaker-level ?s ?l))(increase (total-cost ) 1))))
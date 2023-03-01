(define (domain termes)
  (:requirements :negative-preconditions :typing)
  (:types object
	object - object
	numb - object
	position - object)
  (:constants )
  (:predicates (height ?p - position ?h - numb)
	(at ?p - position)
	(has-block )
	(succ ?n1 - numb ?n2 - numb)
	(neighbor ?p1 - position ?p2 - position)
	(is-depot ?p - position)
	(= ?x - object ?y - object)
	(= ?x - object ?y - object))
  (:functions )
  (:action move
	:parameters (?from - position
		?to - position
		?h - numb)
	:precondition (and
		(at ?from)
		(neighbor ?from ?to)
		(height ?from ?h)
		(height ?to ?h))
	:effect (and
		(not (at ?from))
		(at ?to)))

  (:action move-up
	:parameters (?from - position
		?hfrom - numb
		?to - position
		?hto - numb)
	:precondition (and
		(at ?from)
		(neighbor ?from ?to)
		(height ?from ?hfrom)
		(height ?to ?hto)
		(succ ?hto ?hfrom))
	:effect (and
		(not (at ?from))
		(at ?to)))

  (:action move-down
	:parameters (?from - position
		?hfrom - numb
		?to - position
		?hto - numb)
	:precondition (and
		(at ?from)
		(neighbor ?from ?to)
		(height ?from ?hfrom)
		(height ?to ?hto)
		(succ ?hfrom ?hto))
	:effect (and
		(not (at ?from))
		(at ?to)))

  (:action place-block
	:parameters (?rpos - position
		?bpos - position
		?hbefore - numb
		?hafter - numb)
	:precondition (and
		(at ?rpos)
		(neighbor ?rpos ?bpos)
		(height ?rpos ?hbefore)
		(height ?bpos ?hbefore)
		(succ ?hafter ?hbefore)
		(has-block )
		(not (is-depot ?bpos)))
	:effect (and
		(not (height ?bpos ?hbefore))
		(height ?bpos ?hafter)
		(not (has-block ))
		(at ?rpos)
		(succ ?hbefore ?hbefore)))

  (:action remove-block
	:parameters (?rpos - position
		?bpos - position
		?hbefore - numb
		?hafter - numb)
	:precondition (and
		(at ?rpos)
		(neighbor ?rpos ?bpos)
		(height ?rpos ?hafter)
		(height ?bpos ?hbefore)
		(succ ?hbefore ?hafter)
		(not (has-block ))
		(succ ?hafter ?hafter))
	:effect (and
		(not (height ?bpos ?hbefore))
		(height ?bpos ?hafter)
		(has-block )))

  (:action create-block
	:parameters (?p - position)
	:precondition (and
		(at ?p)
		(not (has-block ))
		(is-depot ?p))
	:effect (and
		(has-block )))

  (:action destroy-block
	:parameters (?p - position)
	:precondition (and
		(at ?p)
		(has-block )
		(is-depot ?p))
	:effect (and
		(not (has-block )))))
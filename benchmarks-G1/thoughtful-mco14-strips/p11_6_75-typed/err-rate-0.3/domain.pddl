(define (domain thoughtful-typed)
  (:requirements :typing)
  (:types
	object
	card - object
	colnum - object
	num - object
	suittype - object)
  (:constants )
  (:predicates
	(on ?c1 - card ?c2 - card)
	(ace ?c - card)
	(king ?c - card)
	(clear ?c - card)
	(colspace ?n - colnum)
	(bottomtalon ?c - card)
	(toptalon ?c - card)
	(ontalon ?c1 - card ?c2 - card)
	(talonplayable ?c - card)
	(instack ?c - card)
	(home ?c - card)
	(faceup ?c - card)
	(bottomcol ?c - card)
	(suit ?c - card ?s - suittype)
	(value ?c - card ?v - num)
	(successor ?n1 - num ?n0 - num)
	(canstack ?c1 - card ?c2 - card)
	(colsuccessor ?n1 - colnum ?n0 - colnum)
	(= ?x - object ?y - object))
  (:functions )
  (:action move-col-to-col
	:parameters (?card - card
		?oldcard - card
		?newcard - card)
	:precondition (and
		(faceup ?card)
		(clear ?newcard)
		(canstack ?card ?newcard)
		(on ?card ?oldcard))
	:effect (and
		(on ?card ?newcard)
		(clear ?oldcard)
		(faceup ?oldcard)
		(not (on ?card ?oldcard))
		(not (clear ?newcard))))

(:action move-col-to-col-b
	:parameters (?card - card
		?newcard - card
		?cols - colnum
		?ncols - colnum)
	:precondition (and
		(faceup ?card)
		(bottomcol ?card)
		(clear ?newcard)
		(canstack ?card ?newcard)
		(colspace ?cols)
		(colsuccessor ?ncols ?cols))
	:effect (and
		(on ?card ?newcard)
		(colspace ?ncols)
		(not (bottomcol ?card))
		(not (clear ?newcard))
		(not (colspace ?cols))))

(:action move-col-to-col-c
	:parameters (?card - card
		?oldcard - card
		?cols - colnum
		?ncols - colnum)
	:precondition (and
		(faceup ?card)
		(king ?card)
		(colspace ?cols)
		(colsuccessor ?cols ?ncols)
		(on ?card ?oldcard))
	:effect (and
		(bottomcol ?card)
		(clear ?oldcard)
		(faceup ?oldcard)
		(colspace ?ncols)
		(not (on ?card ?oldcard))
		(not (colspace ?cols))))

(:action col-to-home
	:parameters (?card - card
		?oldcard - card
		?suit - suittype
		?vcard - num
		?homecard - card
		?vhomecard - num)
	:precondition (and
		(clear ?card)
		(on ?card ?oldcard)
		(home ?homecard)
		(suit ?card ?suit)
		(suit ?homecard ?suit)
		(value ?card ?vcard)
		(value ?homecard ?vhomecard)
		(successor ?vcard ?vhomecard))
	:effect (and
		(home ?card)
		(faceup ?oldcard)
		(on ?card ?homecard)
		(not (on ?card ?oldcard))
		(not (home ?homecard))
		(not (faceup ?card))
		(not (clear ?card))))

(:action col-to-home-b
	:parameters (?card - card
		?homecard - card
		?suit - suittype
		?vcard - num
		?vhomecard - num
		?cols - colnum
		?ncols - colnum)
	:precondition (and
		(clear ?card)
		(bottomcol ?card)
		(home ?homecard)
		(suit ?card ?suit)
		(suit ?homecard ?suit)
		(value ?card ?vcard)
		(value ?homecard ?vhomecard)
		(successor ?vcard ?vhomecard)
		(colspace ?cols)
		(colsuccessor ?ncols ?cols))
	:effect (and
		(colspace ?ncols)
		(not (home ?homecard))
		(not (faceup ?card))
		(not (clear ?card))
		(not (bottomcol ?card))
		(not (colspace ?cols))))

(:action tal-to-col
	:parameters (?card - card
		?oldcard - card
		?newcard - card
		?cardabove - card)
	:precondition (and
		(clear ?newcard)
		(ontalon ?card ?oldcard)
		(ontalon ?cardabove ?card)
		(talonplayable ?card)
		(canstack ?card ?newcard))
	:effect (and
		(clear ?card)
		(faceup ?card)
		(talonplayable ?oldcard)
		(on ?card ?newcard)
		(ontalon ?cardabove ?oldcard)
		(not (clear ?newcard))
		(not (talonplayable ?card))
		(not (ontalon ?card ?oldcard))
		(not (ontalon ?cardabove ?card))))

(:action tal-to-col-b
	:parameters (?card - card
		?newcard - card
		?cardabove - card)
	:precondition (and
		(clear ?newcard)
		(ontalon ?cardabove ?card)
		(talonplayable ?card)
		(bottomtalon ?card)
		(canstack ?card ?newcard))
	:effect (and
		(clear ?card)
		(faceup ?card)
		(on ?card ?newcard)
		(bottomtalon ?cardabove)
		(talonplayable ?cardabove)
		(not (bottomtalon ?card))
		(not (talonplayable ?card))
		(not (clear ?newcard))
		(not (ontalon ?cardabove ?card))))

(:action tal-to-col-c
	:parameters (?card - card
		?newcard - card
		?oldcard - card)
	:precondition (and
		(clear ?newcard)
		(ontalon ?card ?oldcard)
		(canstack ?card ?newcard)
		(talonplayable ?card)
		(toptalon ?card))
	:effect (and
		(clear ?card)
		(faceup ?card)
		(on ?card ?newcard)
		(toptalon ?oldcard)
		(talonplayable ?oldcard)
		(not (clear ?newcard))
		(not (toptalon ?card))
		(not (talonplayable ?card))
		(not (ontalon ?card ?oldcard))))

(:action tal-to-col-d
	:parameters (?card - card
		?newcard - card)
	:precondition (and
		(clear ?newcard)
		(canstack ?card ?newcard)
		(bottomtalon ?card)
		(toptalon ?card)
		(talonplayable ?card))
	:effect (and
		(clear ?card)
		(faceup ?card)
		(on ?card ?newcard)
		(not (clear ?newcard))
		(not (toptalon ?card))
		(not (talonplayable ?card))
		(not (bottomtalon ?card))))

(:action tal-to-col-e
	:parameters (?card - card
		?oldcard - card
		?cardabove - card
		?cols - colnum
		?ncols - colnum)
	:precondition (and
		(king ?card)
		(ontalon ?card ?oldcard)
		(ontalon ?cardabove ?card)
		(talonplayable ?card)
		(colspace ?cols)
		(colsuccessor ?cols ?ncols))
	:effect (and
		(clear ?card)
		(faceup ?card)
		(talonplayable ?oldcard)
		(ontalon ?cardabove ?oldcard)
		(bottomcol ?card)
		(colspace ?ncols)
		(not (colspace ?cols))
		(not (talonplayable ?card))
		(not (ontalon ?card ?oldcard))
		(not (ontalon ?cardabove ?card))))

(:action tal-to-col-f
	:parameters (?card - card
		?cardabove - card
		?cols - colnum
		?ncols - colnum)
	:precondition (and
		(king ?card)
		(ontalon ?cardabove ?card)
		(talonplayable ?card)
		(bottomtalon ?card)
		(colspace ?cols)
		(colsuccessor ?cols ?ncols))
	:effect (and
		(clear ?card)
		(faceup ?card)
		(bottomtalon ?cardabove)
		(talonplayable ?cardabove)
		(bottomcol ?card)
		(colspace ?ncols)
		(not (colspace ?cols))
		(not (bottomtalon ?card))
		(not (talonplayable ?card))
		(not (ontalon ?cardabove ?card))))

(:action tal-to-col-g
	:parameters (?card - card
		?oldcard - card
		?cols - colnum
		?ncols - colnum)
	:precondition (and
		(king ?card)
		(ontalon ?card ?oldcard)
		(talonplayable ?card)
		(colspace ?cols)
		(colsuccessor ?cols ?ncols)
		(toptalon ?card))
	:effect (and
		(clear ?card)
		(faceup ?card)
		(talonplayable ?oldcard)
		(bottomcol ?card)
		(colspace ?ncols)
		(not (colspace ?cols))
		(not (toptalon ?card))
		(not (talonplayable ?card))
		(not (ontalon ?card ?oldcard))))

(:action tal-to-col-h
	:parameters (?card - card
		?cols - colnum
		?ncols - colnum)
	:precondition (and
		(king ?card)
		(bottomtalon ?card)
		(toptalon ?card)
		(colspace ?cols)
		(colsuccessor ?cols ?ncols)
		(talonplayable ?card))
	:effect (and
		(clear ?card)
		(bottomcol ?card)
		(colspace ?ncols)
		(not (colspace ?cols))
		(not (toptalon ?card))
		(not (talonplayable ?card))
		(not (bottomtalon ?card))))

(:action tal-to-home
	:parameters (?card - card
		?cardabove - card
		?cardbelow - card
		?homecard - card
		?cardsuit - suittype
		?vcard - num
		?vhomecard - num)
	:precondition (and
		(talonplayable ?card)
		(ontalon ?cardabove ?card)
		(ontalon ?card ?cardbelow)
		(suit ?card ?cardsuit)
		(suit ?homecard ?cardsuit)
		(home ?homecard)
		(value ?card ?vcard)
		(value ?homecard ?vhomecard)
		(successor ?vcard ?vhomecard))
	:effect (and
		(talonplayable ?cardbelow)
		(not (talonplayable ?card))
		(not (ontalon ?cardabove ?card))
		(not (ontalon ?card ?cardbelow))
		(home ?card)
		(not (home ?homecard))))

(:action tal-to-home-b
	:parameters (?card - card
		?cardabove - card
		?homecard - card
		?cardsuit - suittype
		?vcard - num
		?vhomecard - num)
	:precondition (and
		(talonplayable ?card)
		(ontalon ?cardabove ?card)
		(bottomtalon ?card)
		(home ?homecard)
		(suit ?card ?cardsuit)
		(suit ?homecard ?cardsuit)
		(value ?card ?vcard)
		(value ?homecard ?vhomecard)
		(successor ?vcard ?vhomecard))
	:effect (and
		(bottomtalon ?cardabove)
		(talonplayable ?cardabove)
		(home ?card)
		(not (bottomtalon ?card))
		(not (talonplayable ?card))
		(not (ontalon ?cardabove ?card))
		(not (home ?homecard))))

(:action tal-to-home-c
	:parameters (?card - card
		?cardbelow - card
		?homecard - card
		?cardsuit - suittype
		?vcard - num
		?vhomecard - num)
	:precondition (and
		(ontalon ?card ?cardbelow)
		(talonplayable ?card)
		(toptalon ?card)
		(home ?homecard)
		(suit ?card ?cardsuit)
		(suit ?homecard ?cardsuit)
		(value ?card ?vcard)
		(value ?homecard ?vhomecard)
		(successor ?vcard ?vhomecard))
	:effect (and
		(toptalon ?cardbelow)
		(talonplayable ?cardbelow)
		(home ?card)
		(not (home ?homecard))
		(not (toptalon ?card))
		(not (talonplayable ?card))
		(not (ontalon ?card ?cardbelow))))

(:action tal-to-home-d
	:parameters (?card - card
		?homecard - card
		?cardsuit - suittype
		?vcard - num
		?vhomecard - num)
	:precondition (and
		(bottomtalon ?card)
		(toptalon ?card)
		(talonplayable ?card)
		(home ?homecard)
		(suit ?card ?cardsuit)
		(suit ?homecard ?cardsuit)
		(value ?card ?vcard)
		(value ?homecard ?vhomecard)
		(successor ?vcard ?vhomecard))
	:effect (and
		(home ?card)
		(not (home ?homecard))
		(not (toptalon ?card))
		(not (talonplayable ?card))
		(not (bottomtalon ?card))))

(:action home-to-col
	:parameters (?card - card
		?cardbelow - card
		?newcard - card
		?cardsuit - suittype
		?vcard - num
		?vcardbelow - num)
	:precondition (and
		(home ?card)
		(suit ?card ?cardsuit)
		(suit ?cardbelow ?cardsuit)
		(value ?card ?vcard)
		(value ?cardbelow ?vcardbelow)
		(successor ?vcard ?vcardbelow)
		(canstack ?card ?newcard)
		(clear ?newcard))
	:effect (and
		(clear ?card)
		(faceup ?card)
		(home ?cardbelow)
		(on ?card ?newcard)
		(not (home ?card))
		(not (clear ?newcard))))

(:action home-to-col-a
	:parameters (?card - card
		?cardbelow - card
		?cardsuit - suittype
		?vcard - num
		?vcardbelow - num
		?cols - colnum
		?ncols - colnum)
	:precondition (and
		(home ?card)
		(king ?card)
		(suit ?card ?cardsuit)
		(suit ?cardbelow ?cardsuit)
		(value ?card ?vcard)
		(value ?cardbelow ?vcardbelow)
		(successor ?vcard ?vcardbelow)
		(colspace ?cols)
		(colsuccessor ?cols ?ncols))
	:effect (and
		(home ?cardbelow)
		(bottomcol ?card)
		(clear ?card)
		(faceup ?card)
		(colspace ?ncols)
		(not (colspace ?cols))
		(not (home ?card))))

(:action turn-deck
	:parameters (?card - card
		?c1 - card)
	:precondition (and
		(talonplayable ?card)
		(ontalon ?c1 ?card))
	:effect (and
		(not (talonplayable ?card))))

(:action turn-deck-a
	:parameters (?card - card
		?c1 - card)
	:precondition (and
		(talonplayable ?card)
		(toptalon ?card)
		(bottomtalon ?c1))
	:effect (and
		(not (talonplayable ?card)))) )
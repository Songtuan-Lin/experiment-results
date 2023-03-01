(define (domain pipesworld_strips)
  (:requirements :strips :typing)
  (:types
	object
	pipe - object
	area - object
	product - object
	batch-atom - object)
  (:constants lco - product gasoleo - product rat-a - product oca1 - product oc1b - product)
  (:predicates
	(connect ?from - area ?to - area ?pipe - pipe)
	(unitary ?pipe - pipe)
	(not-unitary ?pipe - pipe)
	(last ?batch-atom - batch-atom ?pipe - pipe)
	(first ?batch-atom - batch-atom ?pipe - pipe)
	(follow ?next - batch-atom ?previous - batch-atom)
	(is-product ?batch-atom - batch-atom ?product - product)
	(on ?batch-atom - batch-atom ?area - area)
	(may-interface ?product-a - product ?product-b - product)
	(normal ?pipe - pipe)
	(push-updating ?pipe - pipe)
	(pop-updating ?pipe - pipe)
	(= ?x - object ?y - object))
  (:functions )
  (:action push-start
	:parameters (?pipe - pipe
		?batch-atom-in - batch-atom
		?from-area - area
		?to-area - area
		?first-batch-atom - batch-atom
		?product-batch-atom-in - product
		?product-first-batch - product)
	:precondition (and
		(normal ?pipe)
		(first ?first-batch-atom ?pipe)
		(connect ?from-area ?to-area ?pipe)
		(on ?batch-atom-in ?from-area)
		(not-unitary ?pipe)
		(is-product ?batch-atom-in ?product-batch-atom-in)
		(is-product ?first-batch-atom ?product-first-batch)
		(may-interface ?product-batch-atom-in ?product-first-batch))
	:effect (and
		(push-updating ?pipe)
		(not (normal ?pipe))
		(first ?batch-atom-in ?pipe)
		(not (first ?first-batch-atom ?pipe))
		(follow ?first-batch-atom ?batch-atom-in)
		(not (on ?batch-atom-in ?from-area))))

(:action push-end
	:parameters (?pipe - pipe
		?from-area - area
		?to-area - area
		?last-batch-atom - batch-atom
		?next-last-batch-atom - batch-atom)
	:precondition (and
		(push-updating ?pipe)
		(last ?last-batch-atom ?pipe)
		(connect ?from-area ?to-area ?pipe)
		(not-unitary ?pipe)
		(follow ?last-batch-atom ?next-last-batch-atom)
		(first ?last-batch-atom ?pipe))
	:effect (and
		(not (push-updating ?pipe))
		(normal ?pipe)
		(not (follow ?last-batch-atom ?next-last-batch-atom))
		(last ?next-last-batch-atom ?pipe)
		(not (last ?last-batch-atom ?pipe))
		(on ?last-batch-atom ?to-area)))

(:action pop-start
	:parameters (?pipe - pipe
		?batch-atom-in - batch-atom
		?from-area - area
		?to-area - area
		?last-batch-atom - batch-atom
		?product-batch-atom-in - product
		?product-last-batch - product)
	:precondition (and
		(normal ?pipe)
		(last ?last-batch-atom ?pipe)
		(connect ?from-area ?to-area ?pipe)
		(on ?batch-atom-in ?to-area)
		(not-unitary ?pipe)
		(is-product ?batch-atom-in ?product-batch-atom-in)
		(is-product ?last-batch-atom ?product-last-batch)
		(may-interface ?product-batch-atom-in ?product-last-batch))
	:effect (and
		(pop-updating ?pipe)
		(not (normal ?pipe))
		(last ?batch-atom-in ?pipe)
		(not (last ?last-batch-atom ?pipe))
		(follow ?batch-atom-in ?last-batch-atom)
		(not (on ?batch-atom-in ?to-area))))

(:action pop-end
	:parameters (?pipe - pipe
		?from-area - area
		?to-area - area
		?first-batch-atom - batch-atom
		?next-first-batch-atom - batch-atom)
	:precondition (and
		(pop-updating ?pipe)
		(first ?first-batch-atom ?pipe)
		(connect ?from-area ?to-area ?pipe)
		(not-unitary ?pipe)
		(follow ?next-first-batch-atom ?first-batch-atom))
	:effect (and
		(not (pop-updating ?pipe))
		(normal ?pipe)
		(not (follow ?next-first-batch-atom ?first-batch-atom))
		(first ?next-first-batch-atom ?pipe)
		(not (first ?first-batch-atom ?pipe))
		(on ?first-batch-atom ?from-area)))

(:action push-unitarypipe
	:parameters (?pipe - pipe
		?batch-atom-in - batch-atom
		?from-area - area
		?to-area - area
		?first-batch-atom - batch-atom
		?product-batch-atom-in - product
		?product-first-batch - product)
	:precondition (and
		(first ?first-batch-atom ?pipe)
		(connect ?from-area ?to-area ?pipe)
		(on ?batch-atom-in ?from-area)
		(unitary ?pipe)
		(is-product ?batch-atom-in ?product-batch-atom-in)
		(is-product ?first-batch-atom ?product-first-batch)
		(may-interface ?product-batch-atom-in ?product-first-batch))
	:effect (and
		(first ?batch-atom-in ?pipe)
		(not (first ?first-batch-atom ?pipe))
		(last ?batch-atom-in ?pipe)
		(not (last ?first-batch-atom ?pipe))
		(not (on ?batch-atom-in ?from-area))
		(on ?first-batch-atom ?to-area)))

(:action pop-unitarypipe
	:parameters (?pipe - pipe
		?batch-atom-in - batch-atom
		?from-area - area
		?to-area - area
		?last-batch-atom - batch-atom
		?product-batch-atom-in - product
		?product-last-batch - product)
	:precondition (and
		(last ?last-batch-atom ?pipe)
		(connect ?from-area ?to-area ?pipe)
		(on ?batch-atom-in ?to-area)
		(unitary ?pipe)
		(is-product ?batch-atom-in ?product-batch-atom-in)
		(is-product ?last-batch-atom ?product-last-batch)
		(may-interface ?product-batch-atom-in ?product-last-batch)
		(on ?batch-atom-in ?from-area))
	:effect (and
		(last ?batch-atom-in ?pipe)
		(not (last ?last-batch-atom ?pipe))
		(first ?batch-atom-in ?pipe)
		(not (first ?last-batch-atom ?pipe))
		(not (on ?batch-atom-in ?to-area))
		(on ?last-batch-atom ?from-area))) )
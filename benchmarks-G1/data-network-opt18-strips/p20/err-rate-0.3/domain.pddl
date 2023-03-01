(define (domain data-network)
  (:requirements :action-costs :adl :equality :negative-preconditions :typing)
  (:types
	object
	data - object
	script - object
	server - object
	numbers - object)
  (:constants )
  (:predicates
	(script-io ?s - script ?in1 - data ?in2 - data ?out - data)
	(connected ?from - server ?to - server)
	(data-size ?d - data ?n - numbers)
	(capacity ?s - server ?n - numbers)
	(sum ?n1 - numbers ?n2 - numbers ?sum - numbers)
	(less-equal ?n1 - numbers ?n2 - numbers)
	(saved ?d - data ?s - server)
	(cached ?d - data ?s - server)
	(usage ?s - server ?n - numbers)
	(= ?x - object ?y - object))
  (:functions (total-cost )
	(process-cost ?sc - script - ?s - server)
	(send-cost ?from - server - ?to - server - ?size - numbers)
	(io-cost ?s - server - ?size - numbers))
  (:action release
	:parameters (?d - data
		?s - server
		?size - numbers
		?before - numbers
		?after - numbers)
	:precondition (and
		(data-size ?d ?size)
		(sum ?after ?size ?before)
		(cached ?d ?s)
		(usage ?s ?before))
	:effect (and
		(not (cached ?d ?s))
		(not (usage ?s ?before))
		(usage ?s ?after)
		(sum ?size ?after ?after)(increase (total-cost ) 0)))

(:action save
	:parameters (?d - data
		?size - numbers
		?s - server)
	:precondition (and
		(data-size ?d ?size)
		(cached ?d ?s))
	:effect (and
		(saved ?d ?s)(increase (total-cost ) (io-cost ?s ?size))))

(:action load
	:parameters (?d - data
		?s - server
		?size - numbers
		?limit - numbers
		?before - numbers
		?after - numbers)
	:precondition (and
		(data-size ?d ?size)
		(capacity ?s ?limit)
		(sum ?before ?size ?after)
		(less-equal ?after ?limit)
		(saved ?d ?s)
		(not (cached ?d ?s))
		(usage ?s ?before))
	:effect (and
		(cached ?d ?s)
		(not (usage ?s ?before))
		(usage ?s ?after)(increase (total-cost ) (io-cost ?s ?size))))

(:action send
	:parameters (?d - data
		?from - server
		?to - server
		?size - numbers
		?limit - numbers
		?before - numbers
		?after - numbers)
	:precondition (and
		(connected ?from ?to)
		(data-size ?d ?size)
		(capacity ?to ?limit)
		(sum ?before ?size ?after)
		(less-equal ?after ?limit)
		(cached ?d ?from)
		(not (cached ?d ?to))
		(usage ?to ?before))
	:effect (and
		(cached ?d ?to)
		(not (usage ?to ?before))
		(usage ?to ?after)(increase (total-cost ) (send-cost ?from ?to ?size))))

(:action process
	:parameters (?in1 - data
		?in2 - data
		?out - data
		?sc - script
		?s - server
		?size - numbers
		?limit - numbers
		?before - numbers
		?after - numbers)
	:precondition (and
		(script-io ?sc ?in1 ?in2 ?out)
		(data-size ?out ?size)
		(capacity ?s ?limit)
		(sum ?before ?size ?after)
		(less-equal ?after ?limit)
		(cached ?in1 ?s)
		(cached ?in2 ?s)
		(not (cached ?out ?s))
		(usage ?s ?before))
	:effect (and
		(cached ?out ?s)
		(not (usage ?s ?before))
		(usage ?s ?after)
		(sum ?size ?after ?after)(increase (total-cost ) (process-cost ?sc ?s)))) )
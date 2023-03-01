(define (domain miconic)
  (:requirements :strips)
  (:types
	object)
  (:constants )
  (:predicates
	(origin ?person - object ?floor - object)
	(floor ?floor - object)
	(passenger ?passenger - object)
	(destin ?person - object ?floor - object)
	(above ?floor1 - object ?floor2 - object)
	(boarded ?person - object)
	(served ?person - object)
	(lift-at ?floor - object)
	(= ?x - object ?y - object))
  (:functions )
  (:action board
	:parameters (?f - object
		?p - object)
	:precondition (and
		(floor ?f)
		(passenger ?p)
		(lift-at ?f)
		(origin ?p ?f))
	:effect (and
		(boarded ?p)
		(not (= ?f ?p))))

(:action depart
	:parameters (?f - object
		?p - object)
	:precondition (and
		(floor ?f)
		(passenger ?p)
		(lift-at ?f)
		(destin ?p ?f)
		(boarded ?p))
	:effect (and
		(not (boarded ?p))
		(served ?p)
		(not (destin ?f ?p))))

(:action up
	:parameters (?f1 - object
		?f2 - object)
	:precondition (and
		(floor ?f1)
		(floor ?f2)
		(lift-at ?f1)
		(above ?f1 ?f2))
	:effect (and
		(lift-at ?f2)
		(not (lift-at ?f1))))

(:action down
	:parameters (?f1 - object
		?f2 - object)
	:precondition (and
		(floor ?f1)
		(floor ?f2)
		(lift-at ?f1)
		(above ?f2 ?f1))
	:effect (and
		(lift-at ?f2)
		(not (lift-at ?f1)))) )
(define (domain satellite)
  (:requirements :equality :strips)
  (:types
	object)
  (:constants )
  (:predicates
	(on_board ?i - object ?s - object)
	(supports ?i - object ?m - object)
	(pointing ?s - object ?d - object)
	(power_avail ?s - object)
	(power_on ?i - object)
	(calibrated ?i - object)
	(have_image ?d - object ?m - object)
	(calibration_target ?i - object ?d - object)
	(satellite ?x - object)
	(direction ?x - object)
	(instrument ?x - object)
	(mode ?x - object)
	(= ?x - object ?y - object))
  (:functions )
  (:action turn_to
	:parameters (?s - object
		?d_new - object
		?d_prev - object)
	:precondition (and
		(satellite ?s)
		(direction ?d_new)
		(direction ?d_prev)
		(pointing ?s ?d_prev))
	:effect (and
		(pointing ?s ?d_new)
		(not (pointing ?s ?d_prev))
		(not (have_image ?s ?d_new))))

(:action switch_on
	:parameters (?i - object
		?s - object)
	:precondition (and
		(instrument ?i)
		(satellite ?s)
		(on_board ?i ?s)
		(power_avail ?s))
	:effect (and
		(power_on ?i)
		(not (calibrated ?i))
		(not (power_avail ?s))
		(not (calibrated ?s))))

(:action switch_off
	:parameters (?i - object
		?s - object)
	:precondition (and
		(instrument ?i)
		(satellite ?s)
		(on_board ?i ?s)
		(power_on ?i))
	:effect (and
		(power_avail ?s)
		(not (power_on ?i))
		(not (= ?i ?s))))

(:action calibrate
	:parameters (?s - object
		?i - object
		?d - object)
	:precondition (and
		(satellite ?s)
		(instrument ?i)
		(direction ?d)
		(on_board ?i ?s)
		(calibration_target ?i ?d)
		(pointing ?s ?d)
		(power_on ?i))
	:effect (and
		(calibrated ?i)))

(:action take_image
	:parameters (?s - object
		?d - object
		?i - object
		?m - object)
	:precondition (and
		(satellite ?s)
		(direction ?d)
		(instrument ?i)
		(mode ?m)
		(calibrated ?i)
		(on_board ?i ?s)
		(supports ?i ?m)
		(power_on ?i)
		(pointing ?s ?d)
		(power_on ?i))
	:effect (and
		(have_image ?d ?m))) )
(define (domain agricola)
  (:requirements :action-costs :negative-preconditions :typing)
  (:types
	object
	actiontag - object
	goods - object
	stage - object
	round - object
	worker - object
	improvement - object
	roundclass - object
	phaseclass - object
	roundparts - object
	resource - object
	room - object
	num - object
	buildtag - actiontag
	animaltag - actiontag
	vegtag - actiontag
	gentag - actiontag
	animal - goods
	vegetable - goods)
  (:constants num0 - num noworker - worker tnormal - roundclass tharvest - roundclass harvest_init - phaseclass harvest_feeding - phaseclass harvest_breeding - phaseclass harvest_end - phaseclass sheep - animal boar - animal cattle - animal grain - vegetable carrot - vegetable wood - resource clay - resource reed - resource stone - resource act_rest - gentag act_labor - gentag act_plow - gentag act_build - gentag act_family - gentag act_sow - gentag act_fences - gentag act_improve - gentag void - gentag act_wood - buildtag act_clay - buildtag act_reed - buildtag act_stone - buildtag oven - improvement fireplace - improvement act_grain - vegtag act_carrot - vegtag act_sheep - animaltag act_boar - animaltag act_cattle - animaltag backhome - roundparts renew - roundparts roundend - roundparts)
  (:predicates
	(next_stage ?s1 - stage ?s2 - stage)
	(current_stage ?s - stage)
	(harvest_phase ?s - stage ?hclass - phaseclass)
	(next_round ?r1 - round ?r2 - round)
	(hold_round ?r - round ?p - roundparts)
	(current_round ?r - round)
	(category_round ?r - round ?t - roundclass)
	(next_worker ?w1 - worker ?w2 - worker)
	(current_worker ?w - worker)
	(max_worker ?w - worker)
	(newborn )
	(plowed_fields )
	(stored_veg ?v - vegetable)
	(sown_veg ?v - vegetable)
	(can_harvest ?v - vegetable)
	(fences_for ?a - animal)
	(owned_animals ?a - animal)
	(can_breed ?a - animal)
	(next_num ?i1 - num ?i2 - num)
	(next2_num ?i1 - num ?i2 - num)
	(num_substract ?it - num ?iminus - num ?isol - num)
	(food_required ?w - worker ?i - num)
	(open_action ?a - actiontag)
	(available_action ?a - actiontag)
	(drawcard_round ?a - actiontag ?r - round)
	(num_food ?i - num)
	(stored_resource ?r - resource)
	(supply_resource ?s - buildtag ?r - resource)
	(space_rooms ?r - room)
	(built_rooms ?r - room ?w - worker)
	(ok )
	(home_improvement ?imp - improvement)
	(= ?x - object ?y - object))
  (:functions (total-cost )
	(group_worker_cost ?w - worker))
  (:action ag__harvest_collect_end
	:parameters (?r - round
		?s - stage)
	:precondition (and
		(hold_round ?r roundend)
		(harvest_phase ?s harvest_init)
		(category_round ?r tharvest))
	:effect (and
		(not (harvest_phase ?s harvest_init))
		(harvest_phase ?s harvest_feeding)(increase (total-cost ) 1)))

(:action ag__harvest_collecting_veg
	:parameters (?r - round
		?s - stage
		?v - vegetable
		?i1 - num
		?i2 - num
		?i3 - num)
	:precondition (and
		(hold_round ?r roundend)
		(harvest_phase ?s harvest_init)
		(category_round ?r tharvest)
		(sown_veg ?v)
		(num_food ?i1)
		(next2_num ?i1 ?i2)
		(next_num ?i2 ?i3)
		(can_harvest ?v))
	:effect (and
		(not (num_food ?i1))
		(num_food ?i3)
		(not (sown_veg ?v))
		(not (can_harvest ?v))
		(num_substract ?i2 ?i2 ?i2)(increase (total-cost ) 1)))

(:action ag__harvest_collecting_fromoven
	:parameters (?r - round
		?s - stage
		?v - vegetable
		?i1 - num
		?i2 - num
		?i3 - num)
	:precondition (and
		(hold_round ?r roundend)
		(harvest_phase ?s harvest_init)
		(category_round ?r tharvest)
		(home_improvement oven)
		(sown_veg ?v)
		(num_food ?i1)
		(next2_num ?i1 ?i2)
		(next2_num ?i2 ?i3)
		(can_harvest ?v))
	:effect (and
		(not (num_food ?i1))
		(num_food ?i3)
		(not (sown_veg ?v))
		(not (can_harvest ?v))(increase (total-cost ) 1)))

(:action ag__harvest_feed
	:parameters (?r - round
		?s - stage
		?wmax - worker
		?inow - num
		?ifeed - num
		?irest - num)
	:precondition (and
		(hold_round ?r roundend)
		(harvest_phase ?s harvest_feeding)
		(category_round ?r tharvest)
		(max_worker ?wmax)
		(food_required ?wmax ?ifeed)
		(num_food ?inow)
		(num_substract ?inow ?ifeed ?irest))
	:effect (and
		(not (harvest_phase ?s harvest_feeding))
		(harvest_phase ?s harvest_breeding)
		(not (num_food ?inow))
		(num_food ?irest)
		(can_breed sheep)
		(can_breed boar)
		(can_breed cattle)(increase (total-cost ) 1)))

(:action ag__harvest_breeding_animal
	:parameters (?r - round
		?s - stage
		?a - animal
		?i - num
		?i2 - num)
	:precondition (and
		(hold_round ?r roundend)
		(harvest_phase ?s harvest_breeding)
		(category_round ?r tharvest)
		(owned_animals ?a)
		(num_food ?i)
		(next2_num ?i ?i2)
		(can_breed ?a))
	:effect (and
		(not (num_food ?i))
		(not (can_breed ?a))(increase (total-cost ) 1)))

(:action ag__harvest_breed_end
	:parameters (?r - round
		?s - stage)
	:precondition (and
		(hold_round ?r roundend)
		(harvest_phase ?s harvest_breeding)
		(category_round ?r tharvest))
	:effect (and
		(not (harvest_phase ?s harvest_breeding))
		(harvest_phase ?s harvest_end)(increase (total-cost ) 1)))

(:action ag__finish_round_backhome
	:parameters (?r - round
		?maxw - worker)
	:precondition (and
		(current_round ?r)
		(current_worker noworker)
		(max_worker ?maxw)
		(not (newborn )))
	:effect (and
		(not (current_worker noworker))
		(current_worker ?maxw)
		(not (current_round ?r))
		(hold_round ?r backhome)(increase (total-cost ) 1)))

(:action ag__finish_round_backhome_withchild
	:parameters (?r - round
		?maxw - worker
		?newmax - worker)
	:precondition (and
		(current_round ?r)
		(current_worker noworker)
		(max_worker ?maxw)
		(next_worker ?newmax ?maxw)
		(newborn ))
	:effect (and
		(current_worker ?newmax)
		(not (max_worker ?maxw))
		(max_worker ?newmax)
		(not (current_round ?r))
		(not (newborn ))
		(hold_round ?r backhome)(increase (total-cost ) 1)))

(:action ag__finish_round_renew
	:parameters (?r - round
		?maxw - worker)
	:precondition (hold_round ?r backhome)
	:effect (and
		(not (hold_round ?r backhome))
		(hold_round ?r roundend)
		(available_action act_rest)
		(available_action act_labor)
		(available_action act_plow)
		(available_action act_grain)
		(available_action act_sow)
		(available_action act_sheep)
		(available_action act_wood)
		(available_action act_clay)
		(available_action act_stone)
		(available_action act_family)
		(available_action act_build)
		(available_action act_fences)
		(available_action act_improve)
		(can_harvest grain)
		(can_harvest carrot)(increase (total-cost ) 1)))

(:action ag__advance_round_normal
	:parameters (?r1 - round
		?r2 - round
		?act - actiontag)
	:precondition (and
		(category_round ?r1 tnormal)
		(hold_round ?r1 roundend)
		(next_round ?r1 ?r2)
		(drawcard_round ?act ?r2)
		(next_round ?r1 ?r2))
	:effect (and
		(not (hold_round ?r1 roundend))
		(current_round ?r2)
		(open_action ?act)(increase (total-cost ) 1)))

(:action ag__finish_stage
	:parameters (?s1 - stage
		?s2 - stage
		?r1 - round
		?r2 - round
		?act - actiontag)
	:precondition (and
		(category_round ?r1 tharvest)
		(hold_round ?r1 roundend)
		(harvest_phase ?s1 harvest_end)
		(current_stage ?s1)
		(next_stage ?s1 ?s2)
		(next_round ?r1 ?r2)
		(drawcard_round ?act ?r2))
	:effect (and
		(not (hold_round ?r1 roundend))
		(not (current_stage ?s1))
		(current_round ?r2)
		(current_stage ?s2)
		(harvest_phase ?s2 harvest_init)
		(open_action ?act)(increase (total-cost ) 1)))

(:action take_food
	:parameters (?w1 - worker
		?w2 - worker
		?wmax - worker
		?r - round
		?i1 - num
		?i2 - num)
	:precondition (and
		(available_action act_labor)
		(current_worker ?w1)
		(next_worker ?w1 ?w2)
		(max_worker ?wmax)
		(current_round ?r)
		(num_food ?i1)
		(next_num ?i1 ?i2))
	:effect (and
		(not (available_action act_labor))
		(not (current_worker ?w1))
		(current_worker ?w2)
		(not (num_food ?i1))
		(num_food ?i2)
		(next_num ?i2 ?i2)(increase (total-cost ) (group_worker_cost ?wmax))))

(:action plow_field
	:parameters (?w1 - worker
		?w2 - worker
		?wmax - worker
		?r - round)
	:precondition (and
		(available_action act_plow)
		(current_worker ?w1)
		(next_worker ?w1 ?w2)
		(max_worker ?wmax)
		(current_round ?r)
		(not (plowed_fields )))
	:effect (and
		(not (available_action act_plow))
		(plowed_fields )
		(not (current_worker ?w1))
		(current_worker ?w2)
		(current_worker ?wmax)(increase (total-cost ) (group_worker_cost ?wmax))))

(:action take_grain
	:parameters (?w1 - worker
		?w2 - worker
		?wmax - worker
		?r - round
		?v - vegetable)
	:precondition (and
		(available_action act_grain)
		(current_worker ?w1)
		(next_worker ?w1 ?w2)
		(max_worker ?wmax)
		(current_round ?r))
	:effect (and
		(not (available_action act_grain))
		(stored_veg ?v)
		(not (current_worker ?w1))
		(current_worker ?w2)(increase (total-cost ) (group_worker_cost ?wmax))))

(:action build_fences
	:parameters (?a - animal
		?w1 - worker
		?w2 - worker
		?wmax - worker
		?r - round)
	:precondition (and
		(available_action act_fences)
		(open_action act_fences)
		(current_worker ?w1)
		(next_worker ?w1 ?w2)
		(max_worker ?wmax)
		(current_round ?r))
	:effect (and
		(not (available_action act_fences))
		(not (current_worker ?w1))
		(current_worker ?w2)
		(fences_for ?a)(increase (total-cost ) (group_worker_cost ?wmax))))

(:action collect_animal
	:parameters (?a - animal
		?act - animaltag
		?w1 - worker
		?w2 - worker
		?wmax - worker
		?r - round)
	:precondition (and
		(available_action ?act)
		(open_action ?act)
		(current_worker ?w1)
		(next_worker ?w1 ?w2)
		(max_worker ?wmax)
		(current_round ?r)
		(fences_for ?a))
	:effect (and
		(not (available_action ?act))
		(not (current_worker ?w1))
		(current_worker ?w2)
		(owned_animals ?a)
		(fences_for ?a)(increase (total-cost ) (group_worker_cost ?wmax))))

(:action collect_cook_animal
	:parameters (?a - animal
		?act - animaltag
		?w1 - worker
		?w2 - worker
		?wmax - worker
		?r - round
		?i1 - num
		?i2 - num)
	:precondition (and
		(available_action ?act)
		(open_action ?act)
		(current_worker ?w1)
		(next_worker ?w1 ?w2)
		(max_worker ?wmax)
		(current_round ?r)
		(home_improvement fireplace)
		(num_food ?i1)
		(next2_num ?i1 ?i2))
	:effect (and
		(not (available_action ?act))
		(not (current_worker ?w1))
		(current_worker ?w2)
		(not (num_food ?i1))
		(num_food ?i2)
		(ok )(increase (total-cost ) (group_worker_cost ?wmax))))

(:action collect_resource
	:parameters (?w1 - worker
		?w2 - worker
		?wmax - worker
		?r - round
		?act - buildtag
		?res - resource)
	:precondition (and
		(available_action ?act)
		(open_action ?act)
		(current_worker ?w1)
		(next_worker ?w1 ?w2)
		(max_worker ?wmax)
		(current_round ?r)
		(supply_resource ?act ?res))
	:effect (and
		(not (available_action ?act))
		(not (current_worker ?w1))
		(current_worker ?w2)
		(stored_resource ?res)(increase (total-cost ) (group_worker_cost ?wmax))))

(:action build_room
	:parameters (?w1 - worker
		?w2 - worker
		?wmax - worker
		?wnewmax - worker
		?r - round
		?room - room)
	:precondition (and
		(available_action act_build)
		(open_action act_build)
		(current_worker ?w1)
		(next_worker ?w1 ?w2)
		(max_worker ?wmax)
		(next_worker ?wnewmax ?wmax)
		(current_round ?r)
		(stored_resource wood)
		(stored_resource reed)
		(space_rooms ?room))
	:effect (and
		(not (available_action act_build))
		(not (current_worker ?w1))
		(current_worker ?w2)
		(not (space_rooms ?room))
		(built_rooms ?room ?wnewmax)
		(not (stored_resource wood))
		(not (stored_resource reed))(increase (total-cost ) (group_worker_cost ?wmax))))

(:action improve_home
	:parameters (?w1 - worker
		?w2 - worker
		?wmax - worker
		?r - round
		?imp - improvement)
	:precondition (and
		(available_action act_improve)
		(open_action act_improve)
		(current_worker ?w1)
		(next_worker ?w1 ?w2)
		(max_worker ?wmax)
		(current_round ?r)
		(stored_resource clay)
		(stored_resource stone))
	:effect (and
		(not (current_worker ?w1))
		(current_worker ?w2)
		(home_improvement ?imp)
		(not (stored_resource clay))
		(not (stored_resource stone))(increase (total-cost ) (group_worker_cost ?wmax))))

(:action family_growth
	:parameters (?w1 - worker
		?w2 - worker
		?wmax - worker
		?wnewmax - worker
		?r - round
		?res - resource
		?room - room)
	:precondition (and
		(available_action act_family)
		(open_action act_family)
		(current_worker ?w1)
		(next_worker ?w1 ?w2)
		(max_worker ?wmax)
		(next_worker ?wnewmax ?wmax)
		(built_rooms ?room ?wnewmax)
		(current_round ?r))
	:effect (and
		(not (available_action act_family))
		(not (current_worker ?w1))
		(current_worker ?w2)
		(newborn )
		(next_worker ?w2 ?w2)(increase (total-cost ) (group_worker_cost ?wmax))))

(:action sow
	:parameters (?w1 - worker
		?w2 - worker
		?wmax - worker
		?r - round
		?v - vegetable)
	:precondition (and
		(available_action act_sow)
		(open_action act_sow)
		(current_worker ?w1)
		(next_worker ?w1 ?w2)
		(max_worker ?wmax)
		(current_round ?r)
		(plowed_fields )
		(stored_veg ?v))
	:effect (and
		(not (available_action act_plow))
		(not (stored_veg ?v))
		(sown_veg ?v)
		(not (current_worker ?w1))(increase (total-cost ) (group_worker_cost ?wmax)))) )
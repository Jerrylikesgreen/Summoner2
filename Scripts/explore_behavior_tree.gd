class_name ExploreBehaviorTree extends SummonBehaviorTree

@export var explore_time:float = 2.0
@export var _is_exploring:bool = false
@onready var explore_timer: Timer = %ExploreTimer

signal explore_behavior_started()

func start_explore_behavor():
	if current_state == 2:
		return
	_is_exploring = true
	explore_timer.start(explore_time)
	emit_signal("explore_behavior_started")
	

class_name SummonBehaviorTree extends Node


signal state_change(state:int)


@onready var idle_behavior_tree: IdleBehaviorTree = %IdleBehaviorTree
@onready var explore_behavior_tree: ExploreBehaviorTree = %ExploreBehaviorTree
@onready var action_behavior_tree: ActionBehaviorTree = %ActionBehaviorTree

@export_enum("IDLE", "EXPLORE", "ACTION") var current_state = 0

func _ready():
	idle_behavior_tree.start_idle_behavor()
	
	
func change_state(new_state)->void:
	match new_state:
		0:
			current_state = 0
			emit_signal("state_change", current_state)
			idle_behavior_tree.start_idle_behavor()

		1:
			current_state = 1
			emit_signal("state_change", current_state)
			explore_behavior_tree._is_exploring = true
			explore_behavior_tree.start_explore_behavor()
			
		2:
			current_state = 2
			emit_signal("state_change", current_state)
			action_behavior_tree._is_doing_action = true
			action_behavior_tree.start_action_behavior()


func _on_explore_timer_timeout() -> void:
	if current_state == 1:
		change_state(0)
	else:
		return



func _on_wait_timer_timeout() -> void:

	if current_state == 2:
		change_state(1)
	else:
		return

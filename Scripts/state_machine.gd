class_name SummonBehaviorTree extends Node
@onready var idle_behavior_tree: IdleBehaviorTree = %IdleBehaviorTree
@onready var explore_behavior_tree: ExploreBehaviorTree = %ExploreBehaviorTree


@export_enum("IDLE", "EXPLORE", "ACTION") var current_state = 0

signal state_change(state:int)


func change_state(new_state)->void:
	if new_state == 0:
		current_state = 0
		emit_signal("state_change", current_state)
		idle_behavior_tree.start_idle_behavor()
			
	if new_state == 1:
		current_state = 1
		emit_signal("state_change", current_state)
		explore_behavior_tree._is_exploring = true
		explore_behavior_tree.start_explore_behavor()
			
	if new_state == 2:
		current_state = 2
		emit_signal("state_change", current_state)


func _on_explore_timer_timeout() -> void:
	change_state(0)
	pass # Replace with function body.


func _on_wait_timer_timeout() -> void:
	change_state(1)
	pass # Replace with function body.

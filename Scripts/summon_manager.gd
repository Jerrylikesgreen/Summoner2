class_name SummonManager extends Node2D

@onready var label: Label = $Label

@onready var summon_body: SummonBody = %SummonBody
@onready var summon_behavior_tree: SummonBehaviorTree = %SummonBehaviorTree

var summon_name:String
var current_target:Node2D


@export_enum("IDLE", "EXPLORE", "ACTION") var current_state = 0

func _ready() -> void:
	summon_body.summon_type()
	
	
func _process(_delta: float) -> void:
	label.set_text(str(current_target))
	pass

func stop_movement()->void:
	summon_body.velocity = Vector2.ZERO 
	

func move_to_body_entered()->void:
	summon_behavior_tree.change_state(2)
	
	


func _on_summon_behavior_tree_state_change(state: int) -> void:
	current_state = state


func _on_action_behavior_tree_action_behavior_started() -> void:
	
	pass # Replace with function body.


func _on_detection_body_entered(body: Node2D) -> void:
	summon_behavior_tree.change_state(2)
	summon_body.target_position = to_local(body.global_position)
	summon_body.target = body
	move_to_body_entered()
	current_target = body
	print(current_target)
	pass # Replace with function body.
 

func _on_summon_body_on_idle_too_long() -> void:
	summon_behavior_tree.change_state(1)
	pass # Replace with function body.

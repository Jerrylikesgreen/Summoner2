class_name SummonManager extends Node2D
@onready var state_lable: Label = %StateLabel
@onready var data_lable: Label = %Data
@onready var detection_lable: Label = %DetectionLable
@onready var moving_to: Label = %MovingTo
@onready var idle: Label = $LableContainer/Idle

@onready var summon_body: SummonBody = %SummonBody

@onready var summon_behavior_tree: SummonBehaviorTree = %SummonBehaviorTree

var summon_name:String

@export_enum("IDLE", "EXPLORE", "ACTION") var current_state = 0

func _ready() -> void:
	summon_body.summon_type() 
	

func _process(_delta: float) -> void:
	state_lable.set_text(str(current_state))
	data_lable.set_text(summon_name)


func stop_movement()->void:
	summon_body.velocity = Vector2.ZERO 
	

func move_to_body_entered()->void:
	moving_to.set_text("moving to target")
	summon_behavior_tree.change_state(2)
	
	


func _on_summon_behavior_tree_state_change(state: int) -> void:
	current_state = state


func _on_action_behavior_tree_action_behavior_started() -> void:
	
	pass # Replace with function body.


func _on_detection_body_entered(body: Node2D) -> void:
	summon_behavior_tree.change_state(2)
	var test = body.name
	var text = str(to_local(body.global_position))
	summon_body.target = to_local(body.global_position)
	move_to_body_entered()
	detection_lable.set_text(text)
	pass # Replace with function body.


func _on_summon_body_on_idle_too_long() -> void:
	summon_behavior_tree.change_state(1)
	pass # Replace with function body.

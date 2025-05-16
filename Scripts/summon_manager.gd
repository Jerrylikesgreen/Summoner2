class_name SummonManager extends Node2D
@onready var state_lable: Label = %StateLabel
@onready var data_lable: Label = %Data
@onready var label: Label = %Label
@onready var detection_lable: Label = %DetectionLable

@onready var summon_body:  = $SummonBody
@onready var summon_behavior_tree: SummonBehaviorTree = %SummonBehaviorTree

var summon_name:String

@export_enum("IDLE", "EXPLORE", "ACTION") var current_state = 0

func _ready() -> void:
	summon_body.summon_type() 
	summon_behavior_tree.change_state(0)
	

func _process(_delta: float) -> void:
	state_lable.set_text(str(current_state))
	data_lable.set_text(summon_name)


func _on_vision_body_entered(body: Node2D) -> void:
	var test = body.selected_resource.name
	label.set_text(test)


func stop_movement()->void:
	summon_body.velocity = Vector2.ZERO 
	

func move_to_body_entered(body_position:Vector2)->void:
	var target_position = body_position
	label.set_text("move_to_body_entered")

func _on_detection_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass
	


func _on_summon_behavior_tree_state_change(state: int) -> void:
	current_state = state

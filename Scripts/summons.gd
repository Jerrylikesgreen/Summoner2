class_name SummonManager extends Node2D
@onready var summon_body:  = $SummonBody
@onready var label: Label = $Label
@export var target: Vector2 

func _ready() -> void:
	summon_body.summon_type() 
	


func _process(delta: float) -> void:
	pass


func _on_vision_body_entered(body: Node2D) -> void:
	label.set_text(str(body))


func move_to_body_entered(body_position:Vector2)->void:
	var target_position = body_position


func _on_detection_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	label.set_text(str(body))

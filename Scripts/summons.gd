class_name Summon extends Node2D
@onready var summon_body: SummonBody = $SummonBody

@export var target: Vector2 

func _ready() -> void:
	summon_body.summon_type() 
	

func _process(delta: float) -> void:
	pass


func _on_vision_body_entered(body: Node2D) -> void:
	match body:
		pass
	pass # Replace with function body.

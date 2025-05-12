class_name SummonCircle extends Node2D

@onready var world: Node2D = $".."
@onready var icon: Sprite2D = $Icon


@export var _is_summoning: bool = false

const SUMMONS = preload("res://summons.tscn")
var summon_target_position:Vector2



func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	get_input()
	 


func get_input() -> void:
	if Input.is_action_pressed("Summon"):
		icon.set_visible(true)
		
		summon_target_position = get_global_mouse_position()
		set_position(summon_target_position)
		_is_summoning = true

	else:
		icon.set_visible(false)
		_is_summoning = false
		return
	if Input.is_mouse_button_pressed(1):
		if _is_summoning == true:
			spawn_summon()
			return


func spawn_summon() -> void:
	var summon = SUMMONS.instantiate()
	world.add_child(summon)
	summon.position = summon_target_position
	return

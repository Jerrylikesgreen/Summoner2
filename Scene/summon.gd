class_name SummonCircle extends Node2D

@onready var world: Node2D = $".."
@onready var icon: Sprite2D = $Icon
enum SummonColor { YELLOW, GREEN, BLUE }
@export var summon_color : SummonColor = SummonColor.YELLOW

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
		if Input.is_action_just_pressed("SummonScrollUp"):
			summon_color += 1
			if summon_color > 2:
				summon_color = 0

		if Input.is_action_just_pressed("SummonScrollDown"):
			summon_color -= 1
			if summon_color < 0:
				summon_color = 2
			
		Globals.emit_signal(
			"debug_signal", 
			"Summoning", 
			SummonColor.find_key(summon_color)
) 

	else:
		icon.set_visible(false)
		_is_summoning = false
		return
	if Input.is_action_just_pressed("Click"):
		if _is_summoning == true:
			spawn_summon()
			return


func spawn_summon() -> void:
	var summon = SUMMONS.instantiate()
	world.add_child(summon)
	summon.position = summon_target_position
	return

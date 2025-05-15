class_name SummonCircle extends Node2D

@onready var target: Node2D = $".."
@onready var icon: Sprite2D = $Icon


enum SummonColor { YELLOW, GREEN, BLUE }
@export var summon_color : SummonColor = SummonColor.YELLOW
@export var _is_summoning: bool = false

const SUMMONS = preload("res://Scenes/summon_manager.tscn")
var summon_target_position:Vector2
var summon = SUMMONS.instantiate()
var all_summons = {} # Dictionary : id -> Summon
var next_enemy_id = 0
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	get_input()


func get_input() -> void:
	if Input.is_action_pressed("Summon"):
		icon.set_visible(true)
		color_summon_circle() 
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

func color_summon_circle() -> void:
	match summon_color:
		SummonColor.YELLOW:
			icon.modulate = Color.YELLOW
		SummonColor.GREEN:
			icon.modulate = Color.GREEN
		SummonColor.BLUE:
			icon.modulate = Color.BLUE

func generate_unique_id():
	next_enemy_id += 1
	return next_enemy_id

func color_summon() -> Color:
	match summon_color:
		SummonColor.YELLOW:
			return Color.YELLOW
		SummonColor.GREEN:
			return Color.GREEN
		SummonColor.BLUE:
			return Color.BLUE
		_:
			return Color.WHITE  # fallback if no match

func spawn_summon() -> void:
	var spawn  = SUMMONS.instantiate()
	var id = generate_unique_id() 
	target.add_child(spawn)
	all_summons[id] = spawn
	spawn.modulate = color_summon()
	spawn.position = summon_target_position
	
	return

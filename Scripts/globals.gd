extends Node
@onready var summon_manager: SummonManager = $"."

#globals

var _is_player_moving: bool = false
var _is_player_summoning: bool = false
var global_player_position: Vector2 

signal debug_signal(debug_header:String, output:String)
signal global_player_position_signal(player_position:Vector2)

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_is_player_moving(bool, player_position:Vector2) -> void:
	_is_player_moving = bool
	emit_signal("debug_signal", "set_is_player_moving", str(_is_player_moving))
	emit_signal("global_player_position_signal", player_position)

var main_scene_ref = null

func check_instanced_node():
	if main_scene_ref:
		var instanced = main_scene_ref.get_node("SummonManager")
		print(instanced.some_property)

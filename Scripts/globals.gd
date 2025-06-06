extends Node
#globals

@onready var data: DATA
##  DATA 
const SAVE_PATH = "res://Resources/DATA/data_resource.tres"
const DEFAULT_DATA = preload("res://Resources/DATA/data_resource.tres")



## Checks
var _is_player_moving: bool = false
var _is_player_summoning: bool = false

## gloabl variables
var global_player_position: Vector2 
var main_scene_ref = null

## signals
signal debug_signal(debug_header:String, output:String)
signal global_player_position_signal(player_position:Vector2)


#----------------------------------------------[ READY ]----------------------------------------------------------
func _ready() -> void:
	_load_data()


func _process(_delta: float) -> void:
	pass



#----------------------------------------------[SETTERS]-------------------------------------------------------------
func set_is_player_moving(bool_value, player_position:Vector2) -> void:
	_is_player_moving = bool_value
	emit_signal("debug_signal", "set_is_player_moving", str(_is_player_moving))
	emit_signal("global_player_position_signal", player_position)

#----------------------------------------------[CHECKERS]-------------------------------------------------------------


func check_instanced_node():
	if main_scene_ref:
		var instanced = main_scene_ref.get_node("SummonManager")
		print(instanced.some_property)

# ----------------------------------------------[ DATA ]-----------------------------------------------------------------

func save() -> void:
	var err := ResourceSaver.save(data, SAVE_PATH)
	if err != OK:
		push_error("Game-data save failed: %s" % error_string(err))

func reset_to_factory() -> void:
	data = DEFAULT_DATA.duplicate(true)
	save()

func _load_data() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		data = ResourceLoader.load(SAVE_PATH) as DATA
		if data == null:   ## corrupted file?  fall back safely
			push_warning("Save corrupt, using defaults.")
			data = DEFAULT_DATA.duplicate(true)
	else:
		data = DEFAULT_DATA.duplicate(true)
		save()   ## create the file on first run

func _on_app_exit() -> void:
	save()



#---------------------------------------------------------------------------------------------------------

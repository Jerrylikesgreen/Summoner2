class_name ItemSpawner extends Node2D
@onready var world: Node2D = $".."

@onready var label: Label = $Label

const ITEM_MANAGER = preload("res://Scenes/item_manager.tscn")

@onready var spawn_location_1: Polygon2D = $SpawnLocation
@onready var spawn_location_2: Polygon2D = $SpawnLocation2
@onready var spawn_location_3: Polygon2D = $SpawnLocation3


var _spawn_location_1_is_active:bool = false
var _spawn_location_2_is_active:bool = false
var _spawn_location_3_is_active:bool = false


func _ready() -> void:
	spawn_item(1)

	pass # Replace with function body.




func spawn_item(item_type) -> void:
	var item_instance = ITEM_MANAGER.instantiate()
	var item_position: Vector2
	add_child(item_instance)
	item_position = spawn_location_1.get_position()
	item_instance.set_position(item_position)
	item_instance.apply_item_type(item_type)
	item_instance._update_selected_resource()
	

	
	
	

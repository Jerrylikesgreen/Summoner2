class_name ItemSpawner extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D



@onready var item_spawner: Label = $ItemSpawner

@onready var label: Label = $Label
@onready var spawn_containerRef: Node2D = %SpawnContainer


const ITEM_MANAGER = preload("res://Scenes/item_manager.tscn")

@onready var spawn_location: Sprite2D = %SpawnLocation
@onready var spawn_location_2: Polygon2D = %SpawnLocation2
@onready var spawn_location_3: Polygon2D = %SpawnLocation3

var _spawn_location_1_is_active:bool = false
var _spawn_location_2_is_active:bool = false
var _spawn_location_3_is_active:bool = false


func _ready() -> void:
	spawn_item(3)

	pass # Replace with function body.




func spawn_item(item_type:int) -> void:
	var item_instance = ITEM_MANAGER.instantiate()
	var item_position: Vector2
	add_child(item_instance)
	item_position = spawn_location.position
	item_instance.position = item_position
	item_instance.apply_item_type(item_type)
	item_instance.spawn_container = spawn_containerRef
	item_spawner.set_text(str(item_type))



	
	
	

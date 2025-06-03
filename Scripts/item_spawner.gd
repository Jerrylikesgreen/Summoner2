class_name ItemSpawner extends Node2D


@onready var ground_layer: TileMapLayer = $"../GroundLayer"

@onready var apple_tree: TileMapLayer = %AppleTree

@onready var item_spawner_label: Label = %ItemSpawner




@export var target_path : NodePath

const ITEM_MANAGER = preload("res://Scenes/item_manager.tscn")

var spawn_location = str(apple_tree)




func _ready() -> void:
        item_spawner_label.set_text(spawn_location)

	pass # Replace with function body.




#func spawn_item(item_type:int) -> void:
#	var item_instance = ITEM_MANAGER.instantiate()
#	var item_position: Vector2
#	add_child(item_instance)
#	item_position = spawn_location
#	item_instance.position = item_position
#	item_instance.apply_item_type(item_type)
#	item_instance.spawn_container = spawn_containerRef
#	item_spawner.set_text(str(item_type))



	
	
	

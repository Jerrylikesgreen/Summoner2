class_name ItemSpawner extends Node2D


@onready var ground_layer: TileMapLayer = $"../GroundLayer"

@onready var apple_layer: TileMapLayer = %AppleTree





@export var target_path : NodePath

const ITEM_MANAGER = preload("res://Scenes/item_manager.tscn")




func _ready() -> void:
	var tile_size : Vector2 = apple_layer.tile_set.tile_size
	var half_tile : Vector2 = tile_size * 0.5

	for cell in apple_layer.get_used_cells():                
		#   grid → layer-local pixels → world pixels
		var local_pos  : Vector2 = Vector2(cell) * tile_size + half_tile
		var world_pos  : Vector2 = apple_layer.to_global(local_pos)
		_spawn_item(world_pos, 3)



#----------------------------------------------[Class Methods]-------------------------------------------
func _spawn_item(world_pos: Vector2, spawn_type: int) -> void:
	var inst = ITEM_MANAGER.instantiate()
	add_child(inst)                       # keep items grouped under this node
	inst.global_position = world_pos
	inst.apply_item_type(spawn_type)

	

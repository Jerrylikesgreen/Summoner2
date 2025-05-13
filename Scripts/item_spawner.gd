class_name ItemSpawner extends Node2D


const ITEM_MANAGER = preload("res://Scenes/item_manager.tscn")

@onready var spawn_location_1: Polygon2D = $SpawnLocation
@onready var spawn_location_2: Polygon2D = $SpawnLocation2
@onready var spawn_location_3: Polygon2D = $SpawnLocation3


var _spawn_location_1_is_active:bool = false
var _spawn_location_2_is_active:bool = false
var _spawn_location_3_is_active:bool = false


func _ready() -> void:
	
	pass # Replace with function body.

class_name Player extends Node2D


@onready var character_body_2d: PlayerBody = %CharacterBody2D
@onready var summon_circle: SummonCircle = %SummonCircle


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_summon_circle_summon_spawned() -> void:
	character_body_2d.player_stats.summon_count += 1
	if character_body_2d.check_summon_count() == false:
		summon_circle._can_summon = false
	
	pass # Replace with function body.

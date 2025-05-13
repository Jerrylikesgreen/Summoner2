class_name SummonBody extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite



@export_enum("YELLOW", "GREEN", "BLUE") var SummonType


@export var speed = 100





func _process(delta: float) -> void:

	pass
	
	
func _physics_process(delta):
	check_if_moving()
	move_and_slide()


func summon_type() -> void:
	match get_modulate():
		Color.YELLOW:
			SummonType = 0
		Color.GREEN:
			SummonType = 1
		Color.BLUE:
			SummonType = 2 



func check_if_moving()-> void:
	if velocity == Vector2(0, 0):
		animated_sprite.set_animation("Idle") 

	else:
		animated_sprite.set_animation("Moving") 

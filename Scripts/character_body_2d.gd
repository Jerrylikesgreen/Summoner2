class_name player_body extends CharacterBody2D



@export var speed = 100

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func check_if_moving()-> void:
	if velocity == Vector2(0, 0):
		Globals.set_is_player_moving(false, position)
		animated_sprite_2d.set_animation("Idle") 

	else:
		Globals.set_is_player_moving(true, position)
		animated_sprite_2d.set_animation("Moving") 


func get_input():
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	check_if_moving()
	move_and_slide()

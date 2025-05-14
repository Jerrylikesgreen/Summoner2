class_name SummonBody extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite



@export_enum("YELLOW", "GREEN", "BLUE") var SummonType
@export var speed       : float      = 100.0        
@export var arrive_epsilon : float   = 4.0      

var target:Vector2



func _process(delta: float) -> void:

	pass
	
	
func _physics_process(delta):
	check_if_moving()
	_move_towards_target(delta)
	move_and_slide()


func summon_type() -> void:
	match get_modulate():
		Color.YELLOW:
			SummonType = 0
		Color.GREEN:
			SummonType = 1
		Color.BLUE:
			SummonType = 2 

func _move_towards_target(delta: float) -> void:
	var diff : Vector2 = target - global_position
	if diff.length() > arrive_epsilon:
		velocity = diff.normalized() * speed
		move_and_slide()
	else:
		velocity = Vector2.ZERO                     
	

func check_if_moving()-> void:
	if velocity == Vector2(0, 0):
		animated_sprite.set_animation("Idle") 

	else:
		animated_sprite.set_animation("Moving") 

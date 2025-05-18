class_name player_body extends CharacterBody2D



@onready var label: Label = $"../Label"
@onready var camera: Camera2D = $Camera2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var summon_circle: SummonCircle = $"../SummonCircle"



@export var speed = 100
@export var _camera_locked:bool = false


const ZOOM_STEP := 0.05              # 0.1 = 10 % zoom increment
const ZOOM_MIN  := 0.5              # 0.5× = max zoom-in
const ZOOM_MAX  := 3.0              # 3×   = max zoom-out

func check_if_moving()-> void:
	if velocity == Vector2(0, 0):
		Globals.set_is_player_moving(false, position)
		animated_sprite_2d.set_animation("Idle") 

	else:
		Globals.set_is_player_moving(true, position)
		animated_sprite_2d.set_animation("Moving") 


func get_input():
	player_camera_input()
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_direction * speed
	var text = str(position)
	label.set_text(text)

func _physics_process(delta):
	get_input()
	check_if_moving()
	move_and_slide()
	player_camera_input()



func player_camera_input() -> void:
	if _camera_locked == false:
		var z := camera.zoom            # current Vector2
	
		if Input.is_action_just_pressed("SummonScrollDown"):
			z -= Vector2(ZOOM_STEP, ZOOM_STEP)   # zoom in
		elif Input.is_action_just_pressed("SummonScrollUp"):
			z += Vector2(ZOOM_STEP, ZOOM_STEP)   # zoom out
	
		# clamp both X and Y to the same min/max
		z.x = clampf(z.x, ZOOM_MIN, ZOOM_MAX)
		z.y = clampf(z.y, ZOOM_MIN, ZOOM_MAX)
	
		camera.zoom = z                 # apply


func _on_summon_circle_summoning(bool: Variant) -> void:
	_camera_locked = bool

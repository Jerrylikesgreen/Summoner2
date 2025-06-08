class_name SummonBody
extends CharacterBody2D

signal reached_target_position
signal on_idle_too_long

@onready var summon_manager: SummonManager = $".."
@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite



@export var summon_resource: SummonResource
@export_enum("YELLOW", "GREEN", "BLUE") var SummonType     
@export var arrive_epsilon  : float = 10.0      
@export var target_position : Vector2     
@export var target          : Node2D
var target_resource:Resource
const IDLE_TIMEOUT_SEC := 0.50  # â 20 frames at 60 FPS
var idle_time := 0.0
var wait_time = 0


func _ready() -> void:
	summon_resource = summon_resource.duplicate()
	summon_type()  # Initialize SummonType based on current modulate
	match SummonType:
		
		0:
			summon_resource.speed += 25.0
		
func _process(_delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	match summon_manager.current_state:
		0:  # IDLE
			velocity = Vector2.ZERO

			idle_time += delta
			if idle_time >= IDLE_TIMEOUT_SEC:
				emit_signal("on_idle_too_long")
		1, 2:  # EXPLORE / ACTION
			idle_time = 0.0
			_move_towards_target()

	_update_animation()
	move_and_slide()

# -------------------------------------------------------------

func _move_towards_target() -> void:
	var dist := position.distance_to(target_position)

	if dist <= arrive_epsilon:
		velocity = Vector2.ZERO
		emit_signal("reached_target_position")

	velocity = (target_position - position).normalized() * summon_resource.speed


func _update_animation() -> void:
	if velocity.length() < 0.01:
		animated_sprite.play("Idle")
	else:
		animated_sprite.play("Moving")


# -------------------------------------------------------------

func summon_explore_target() -> void:
	var radius := 300.0                  
	var root := sqrt(randf()) * radius
	var angle := randf() * TAU
	var _offset := Vector2(cos(angle), sin(angle)) * randf() * radius
	target_position = position + Vector2(cos(angle), sin(angle)) * root


func summon_type() -> void:
	match get_modulate():
		Color.YELLOW:
			SummonType = 0
		Color.GREEN:
			SummonType = 1
		Color.BLUE:
			SummonType = 2     


func _on_explore_behavior_tree_explore_behavior_started() -> void:
	summon_explore_target()


func _on_pick_up_pickup_action_started() -> void:
	target_resource = target._on_taken()
	print("target_resource")

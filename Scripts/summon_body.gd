class_name SummonBody
extends CharacterBody2D

signal on_idle_too_long
@onready var t_lable: Label = $"../LableContainer/TLable"
@onready var distance_to_target: Label = %DistanceToTarget
@onready var target_position: Label = %TargetPosition

@onready var summon_manager: SummonManager = $".."
@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite
@onready var moving_to: Label = %MovingTo
@onready var signal_lable: Label = %SignalLable
@onready var label_2: Label = %Label2


@export var summon_resource: SummonResource
@export_enum("YELLOW", "GREEN", "BLUE") var SummonType     
@export var arrive_epsilon  : float = 20.0      
@export var target          : Vector2     
const IDLE_TIMEOUT_SEC := 0.33  # â 20 frames at 60 FPS
var idle_time := 0.0



func _ready() -> void:
	summon_resource.speed
	match SummonType:
		0:
			summon_resource.speed + 25.0

func _process(delta: float) -> void:
	label_2.set_text(str(target))
	t_lable.set_text(str(idle_time))
	
	



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
	var distance_to_target_text = str(position.distance_to(target))
	distance_to_target.set_text(distance_to_target_text)
	
	if position.distance_to(target) <= arrive_epsilon:
		moving_to.set_text("Is at target")
		velocity = Vector2.ZERO        
	var dir := (target - position).normalized()
	velocity = dir * summon_resource.speed
	moving_to.set_text("moving to target")
				  


func _update_animation() -> void:
	if velocity.length() < 0.01:
		animated_sprite.play("Idle")
	else:
		animated_sprite.play("Moving")


# -------------------------------------------------------------

func summon_explore_target() -> void:
	var radius := 300.0                  
	var angle  := randf() * TAU
	var offset := Vector2(cos(angle), sin(angle)) * randf() * radius
	target = position + offset
	
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
	signal_lable.set_text("settiing explore target")

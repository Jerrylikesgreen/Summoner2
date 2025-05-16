class_name SummonBody
extends CharacterBody2D
@onready var summon_manager: SummonManager = $".."


@onready var signal_lable: Label = %SignalLable
@onready var label_2: Label = $"../PanelContainer/Label2"

@export var summon_resource: SummonResource
@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite
@export_enum("YELLOW", "GREEN", "BLUE") var SummonType     
@export var arrive_epsilon  : float = 15.0      
@export var target          : Vector2     


func _ready() -> void:
	summon_resource.speed
	match SummonType:
		0:
			summon_resource.speed + 25.0

func _process(delta: float) -> void:
	label_2.set_text(str(target))

func _physics_process(_delta: float) -> void:
	if summon_manager.current_state == 0:
		velocity = Vector2.ZERO
	if summon_manager.current_state == 1:
		_move_towards_target()
	if summon_manager.current_state == 2:
		_move_towards_target()

	_update_animation()
	move_and_slide()                   


# -------------------------------------------------------------

func _move_towards_target() -> void:
	if position.distance_to(target) <= arrive_epsilon:
		velocity = Vector2.ZERO        
		return
	var dir := (target - position).normalized()
	velocity = dir * summon_resource.speed
				  


func _update_animation() -> void:
	if velocity.length() < 0.01:
		animated_sprite.play("Idle")
	else:
		animated_sprite.play("Moving")


# -------------------------------------------------------------

func summon_explore_target() -> void:
	var radius := 1000.0                  
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
	signal_lable.set_text("_on_explore_behavior_tree_explore_behavior_started")

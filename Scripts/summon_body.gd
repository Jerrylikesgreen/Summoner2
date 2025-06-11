class_name SummonBody
extends CharacterBody2D

# –– SIGNALS ––––––––––––––––––––––––––––––
signal reached_target_position
signal on_idle_too_long          # kept original name

# –– NODES ––––––––––––––––––––––––––––––––––––––––––––
@onready var summon_manager : SummonManager    = $".."
@onready var animated_sprite : AnimatedSprite2D = %AnimatedSprite
@onready var pocket          : Pocket           = %Pocket

# –– EDITOR PROPERTIES ––––––––––––––––––––––––––––––––
@export var summon_resource : SummonResource
@export_enum("YELLOW", "GREEN", "BLUE") var SummonType      # kept original enum
@export var arrive_epsilon  : float = 15.0

# These can be set at runtime through helper(s)
var target_position : Vector2
var target          : Node2D

# –– CONSTANTS ––––––––––––––––––––––––––––––––––––––––
const IDLE_TIMEOUT_SEC := 0.50   # ≈ 20 frames @ 60 FPS

# –– INTERNAL STATE –––––––––––––––––––––––––––––––––––
enum State { IDLE, EXPLORE, ACTION }
var idle_time          : float = 0.0
var has_reached_target : bool  = false

# –– READY ––––––––––––––––––––––––––––––––––––––––––––
func _ready() -> void:
	# If “Local to Scene” isn’t ticked in the inspector, keep this duplicate
	summon_resource = summon_resource.duplicate()
	_apply_summon_type_boost()

# –– PHYSICS ––––––––––––––––––––––––––––––––––––––––––
func _physics_process(delta: float) -> void:
	match summon_manager.current_state:
		State.IDLE:
			velocity   = Vector2.ZERO
			idle_time += delta
			if idle_time >= IDLE_TIMEOUT_SEC:
				emit_signal("on_idle_too_long")

		State.EXPLORE, State.ACTION:
			idle_time = 0.0
			_move_towards_target(delta)

	_update_animation()
	move_and_slide()

# –– MOVEMENT -------------------------------------------------
func _move_towards_target(delta: float) -> void:

	var to_target : Vector2 = target_position - position
	var dist                 = to_target.length()

	if dist <= arrive_epsilon:
		_finish_arrival()
	else:
		# prevent overshoot on low FPS
		var max_step = summon_resource.speed * delta
		velocity     = to_target.normalized() * summon_resource.speed
		if dist < max_step:
			# snap if next step would cross the goal
			position           += to_target
			_finish_arrival()

func _finish_arrival() -> void:
	velocity           = Vector2.ZERO
	has_reached_target = true
	emit_signal("reached_target_position")

# –– ANIMATION ------------------------------------------------
func _update_animation() -> void:
	if velocity.length() < 0.01:
		animated_sprite.play("Idle")
	else:
		animated_sprite.play("Moving")
		animated_sprite.flip_h = velocity.x < 0

# –– HELPERS --------------------------------------------------
func summon_explore_target() -> void:
	var radius  := 300.0
	var offset  := Vector2(randf(), randf()).normalized()
	offset      = offset.rotated(randf() * TAU) * sqrt(randf()) * radius
	set_target_position(position + offset)

func _apply_summon_type_boost() -> void:
	# original enum values: 0-Yellow, 1-Green, 2-Blue
	if SummonType == 0:        # YELLOW
		summon_resource.speed += 25.0

# called by behaviour-tree signal
func _on_explore_behavior_tree_explore_behavior_started() -> void:
	summon_explore_target()

func set_target_position(new_pos: Vector2) -> void:
	target_position      = new_pos
	has_reached_target   = false

# called externally (or connect signal in the editor)
func _on_reached_target_position() -> void:
	if target:
		pocket.inventory.append(target)
		if target.has_method("_on_taken"):
			target._on_taken()

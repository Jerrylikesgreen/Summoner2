# ─────────────────────────────────────────────────────────────────────────
# PlayerBody.gd  – clean & race-free
# ─────────────────────────────────────────────────────────────────────────
class_name PlayerBody
extends CharacterBody2D

# ─── Nodes ───────────────────────────────────────────────────────────────

@onready var camera    : Camera2D         = $Camera2D
@onready var sprite    : AnimatedSprite2D = $AnimatedSprite2D
@onready var summon_ui: SummonCircle = %SummonCircle
@onready var label: Label = %Label

# ─── Exported  ───────────────────────────────────────────────────────────
@export var speed          : float = 100.0
@export var camera_locked  : bool  = false   # toggled by Summon key
@export_enum("North", "South", "East", "West")
var player_direction : int = 2   # East by default

# ─── Direction constants (readable) ──────────────────────────────────────
const DIR_N := 0
const DIR_S := 1
const DIR_E := 2
const DIR_W := 3

# ─── Zoom params ─────────────────────────────────────────────────────────
const ZOOM_STEP := 0.1
const ZOOM_MIN  := 0.5
const ZOOM_MAX  := 3.0

# ─── Internal helpers ────────────────────────────────────────────────────
func _apply_zoom(sign: int) -> void:
	var z := camera.zoom + Vector2.ONE * ZOOM_STEP * sign
	z.x = clampf(z.x, ZOOM_MIN, ZOOM_MAX)
	z.y = z.x                 # keep square pixels
	camera.zoom = z

# ─── Main physics loop ───────────────────────────────────────────────────
func _physics_process(delta: float) -> void:
	_handle_input()
	_handle_movement()

# ─── Movement handling ───────────────────────────────────────────────────
func _handle_input() -> void:
	var dir := Input.get_vector("Left", "Right", "Up", "Down")
	velocity = dir * speed

	# facing & sprite flip
	if dir.x < 0.0:
		player_direction = DIR_W
		sprite.flip_h = true
	elif dir.x > 0.0:
		player_direction = DIR_E
		sprite.flip_h = false
	elif dir.y < 0.0:
		player_direction = DIR_N
	elif dir.y > 0.0:
		player_direction = DIR_S

	label.text = str(global_position)

func _handle_movement() -> void:
	if velocity.is_zero_approx():
		Globals.set_is_player_moving(false, global_position)
		sprite.play("Idle")
	else:
		Globals.set_is_player_moving(true, global_position)
		sprite.play("Moving")

	move_and_slide()

# ─── Central input event hook (handles zoom + lock) ──────────────────────
func _input(event: InputEvent) -> void:
	# 1 — toggle lock immediately when Summon pressed / released
	if event.is_action_pressed("Summon"):
		camera_locked = true
	elif event.is_action_released("Summon"):
		camera_locked = false

	# 2 — block wheel events while locked
	if camera_locked:
		return

	# 3 — zoom on raw wheel events
	if event is InputEventMouseButton and event.is_pressed():
		match event.button_index:
			MOUSE_BUTTON_WHEEL_UP:   _apply_zoom(+1)
			MOUSE_BUTTON_WHEEL_DOWN: _apply_zoom(-1)

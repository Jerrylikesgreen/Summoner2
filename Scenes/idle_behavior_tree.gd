class_name IdleBehaviorTree extends Node
@onready var wait_timer: Timer = %WaitTimer

@export var wait_time: float = 2.0
@export var _is_idle:bool = false

# Idles state should stay Idle unti

func start_idle_behavor():
	_is_idle = true
	wait_timer.start(wait_time)

func _on_idle_wait_time_timeout() -> void:
	_is_idle = false
	pass # Replace with function body.

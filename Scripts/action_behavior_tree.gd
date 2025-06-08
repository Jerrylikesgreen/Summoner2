class_name ActionBehaviorTree extends Node

@onready var summon_body: SummonBody = %SummonBody
@onready var pick_up: Node = %PickUp


@export var _is_doing_action: bool = false

signal action_behavior_started()
signal action_behavior_ended()



func start_action_behavior() -> void:
	await wait_until_velocity_zero()
	emit_signal("action_behavior_ended")

func wait_until_velocity_zero() -> void:
	while summon_body.velocity != Vector2.ZERO:
		await get_tree().process_frame

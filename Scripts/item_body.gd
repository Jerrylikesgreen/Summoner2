class_name ItemBody
extends RigidBody2D

@onready var item_sprite  : Sprite2D = %ItemSprite
@onready var sprite_label: Label = %sprite_label

@onready var selected_resource: ItemResource        

func apply_resource_to_item(res: int) -> void:
	if res == null:
		push_error("apply_resource_to_item received null")
		return  
	#_apply_visuals()

func _apply_visuals() -> void:
	item_sprite.texture = selected_resource.icon
	item_sprite.set_scale(Vector2(2.0, 2.0))
	sprite_label.set_text(str(selected_resource))
	

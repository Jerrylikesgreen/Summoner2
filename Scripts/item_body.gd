class_name ItemBody
extends RigidBody2D

@onready var item_sprite  : Sprite2D = %ItemSprite


@onready var selected_resource: ItemResource        

func apply_resource_to_item(resource: ItemResource) -> void:
        if resource == null:
                push_error("apply_resource_to_item received null")
                return
        #_apply_visuals()

func _apply_visuals() -> void:
	item_sprite.texture = selected_resource.icon
	item_sprite.set_scale(Vector2(2.0, 2.0))

	

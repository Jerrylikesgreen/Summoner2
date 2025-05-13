extends Node2D
class_name ItemManager


@onready var item_body: ItemBody = $ItemBody
@onready var label: Label = $Label
enum ItemType { DEFAULT, MEAT, POTION }

@export var item_type: ItemType = ItemType.DEFAULT



const RESOURCE_POOL := {
	ItemType.MEAT:   preload("res://Resources/meat_resource.tres"),
	ItemType.POTION: preload("res://Resources/potion_resource.tres"),
}

@export var selected_resource: Resource 
func _ready() -> void:
	selected_resource = RESOURCE_POOL.get(item_type)
	if selected_resource:
		item_body.set_texture(selected_resource.sprite)
		pass

func _process(_delta: float) -> void:

	label.text = ItemType.keys()[item_type]

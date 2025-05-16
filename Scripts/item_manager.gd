extends Node2D
class_name ItemManager

@onready var item_body : ItemBody = %ItemBody
@onready var label      : Label    = %Label        
@onready var item_type_lable: Label = %"Item Type"

enum ItemType { DEFAULT, MEAT, POTION }

const RESOURCE_POOL := {
	ItemType.MEAT  : preload("res://Resources/meat_resource.tres"),
	ItemType.POTION: preload("res://Resources/potion_resource.tres"),
}

@export var item_type : ItemType = ItemType.DEFAULT
	  
var item_resource 
var item_name
var selected_resource : Resource                  

func _ready() -> void:
	pass  


func _update_selected_resource() -> void:
	selected_resource = RESOURCE_POOL.get(item_type)
	item_name = selected_resource.name
	item_body.selected_resource = selected_resource
	item_body.position_set = global_position
	
	if label:
		label.text = "Type: %s | Resource: %s" % [item_type, item_name]


func _on_taken()->void:
	queue_free()

func apply_item_type(type: int)->void:
	item_type = type

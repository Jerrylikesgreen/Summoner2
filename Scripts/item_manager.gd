extends Node2D
class_name ItemManager


@onready var item_body : ItemBody = $ItemBody
@onready var label      : Label    = $Label        


enum ItemType { DEFAULT, MEAT, POTION }


const RESOURCE_POOL := {
	ItemType.MEAT  : preload("res://Resources/meat_resource.tres"),
	ItemType.POTION: preload("res://Resources/potion_resource.tres"),
}



@export var item_type : ItemType = ItemType.DEFAULT
	  


var selected_resource : Resource                  

func _ready() -> void:
	pass                 


		

func _update_selected_resource() -> void:
	selected_resource = RESOURCE_POOL.get(item_type)
	
	if label:
		label.text = "Type: %s | Resource: %s" % [item_type, selected_resource]


func _on_taken()->void:
	queue_free()

func apply_item_type(type: int)->void:
	item_type = type

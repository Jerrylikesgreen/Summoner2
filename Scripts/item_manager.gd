class_name ItemManager extends Node2D 

## On ready variables 
@onready var item_body : ItemBody = %ItemBody
## Refrence to Item Body 
@onready var label      : Label    = %Label     
## Refrence to lable 
@onready var item_type_lable: Label = %"Item Type"
@onready var selected_resource_lable: Label = %selected_resource_lable

## Item Type Enum DEFAULT:0, MEAT:1, POTION:2  
enum ItemType { DEFAULT, MEAT, POTION }
##  RESOURCE_POOL is a list of loaded scene files. Meat and Potion 
const RESOURCE_POOL := {
	ItemType.MEAT  : preload("res://Resources/meat_resource.tres"),
	ItemType.POTION: preload("res://Resources/potion_resource.tres"),
}
## item type variable det at defult. can be changed by calling ItemType enum. 
@export var item_type : ItemType = ItemType.DEFAULT
## var holding item resource. 
var item_resource 
## var holding item name. 
var item_name
## var holding selected_resource
var selected_resource : Resource                  

func _ready() -> void:
	selected_resource_lable.set_text(str(selected_resource))
	selected_resource_lable.set_text(str(item_type))
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

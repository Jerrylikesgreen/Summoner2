class_name ItemManager extends Node2D 


@onready var target_position: Label = %"GridContainer/position - Item2"
@onready var sprite_label: Label = %sprite_label

## On ready variables 
@onready var item_body : ItemBody = %ItemBody
## Refrence to Item Body 
@onready var label      : Label    = %Label     
## Refrence to lable 
@onready var item_type_lable: Label = %"Item Type"
@onready var selected_resource_lable: Label = %selected_resource_lable
@onready var s_prite_lable: Label = %SPriteLable
@onready var position___item: Label = %"GridContainer/position - Item"
@export var spawn_position_node_refrence: Node
## Item Type Enum DEFAULT:0, MEAT:1, POTION:2  


enum ItemType { DEFAULT, MEAT, POTION, APPLE }
##  RESOURCE_POOL is a list of loaded scene files. Meat and Potion 
const RESOURCE_POOL := {
	ItemType.MEAT  : preload("res://Resources/meat_resource.tres"),
	ItemType.POTION: preload("res://Resources/potion_resource.tres"),
	ItemType.APPLE: preload("res://Resources/apple_resource.tres"),
}
## item type variable det at defult. can be changed by calling ItemType enum. 
@export var item_type : ItemType = ItemType.DEFAULT
## item type variable det at defult. can be changed by calling ItemType enum.
## var holding item resource. 


var selected_resource : Resource                  
var spawn_container: Node2D 

func _ready() -> void:
	selected_resource_lable.set_text(str(selected_resource))
	selected_resource_lable.set_text(str(item_type))
	
	
	
	pass  

## Called by spawner at spawn time to select resource at spawn and not at instance. 
func _update_selected_resource() -> void:
	selected_resource = RESOURCE_POOL.get(item_type)
	item_body.selected_resource = selected_resource
	sprite_label.set_text(str(item_type))
	item_body._apply_visuals()


func _on_taken()->void:
	queue_free()

func apply_item_type(t:int)->void:
	
	item_type = t
	_update_selected_resource()

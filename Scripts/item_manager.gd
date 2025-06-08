class_name ItemManager extends Node2D 





## On ready variables 
@onready var item_body : ItemBody = %ItemBody
## Reference to Item Body


@export var spawn_position_node_refrence: Node
## Item Type Enum DEFAULT:0, MEAT:1, POTION:2  


enum ItemType { DEFAULT, MEAT, POTION, APPLE }
##  RESOURCE_POOL is a list of loaded scene files. Meat and Potion 
const RESOURCE_POOL := {
	ItemType.MEAT  : preload("res://Resources/meat_resource.tres"),
	ItemType.POTION: preload("res://Resources/potion_resource.tres"),
	ItemType.APPLE: preload("res://Resources/apple_resource.tres"),
}
## item type variable set at default. can be changed by calling ItemType enum. 
@export var item_type : ItemType = ItemType.DEFAULT
## item type variable set at default. can be changed by calling ItemType enum.
## var holding item resource. 


var selected_resource : Resource                  
var spawn_container: Node2D 

func _ready() -> void:

	
	
	
	pass  

## Called by spawner at spawn time to select resource at spawn and not at instance. 
func _update_selected_resource() -> void:
	selected_resource = RESOURCE_POOL.get(item_type)
	item_body.selected_resource = selected_resource
	item_body._apply_visuals()


func _on_taken()->Resource:
	return selected_resource
	queue_free()

func apply_item_type(t:int)->void:
	
	item_type = t
	_update_selected_resource()

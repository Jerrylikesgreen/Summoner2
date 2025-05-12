class_name Debug
extends Control
@onready var player: Node2D = $".."

@onready var debug_label: Label = $DebugLabel

var debug_header: String = ""
var output:       String = ""

func _ready() -> void:
	Globals.debug_signal.connect(_on_debug_signal)  

func _process(delta: float) -> void:
	if player.position != position:
		set_position(player.position)

func _on_debug_signal(header: String, body: String) -> void:
	debug_header = header
	output       = body
	debug_label.text = "%s : %s" % [debug_header, output]  

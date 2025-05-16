extends Label


func _on_explore_timer_timeout() -> void:
	set_text("Explore Timer Received")
	pass # Replace with function body.


func _on_wait_timer_timeout() -> void:
	set_text("Idle Timer Received")

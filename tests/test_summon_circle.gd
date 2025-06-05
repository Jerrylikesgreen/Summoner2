extends Node

func _ready():
    var circle := SummonCircle.new()
    var first_id = circle.generate_unique_id()
    var second_id = circle.generate_unique_id()
    if second_id != first_id + 1:
        push_error("generate_unique_id() failed: %s %s" % [first_id, second_id])
    else:
        print("test_generate_unique_id passed")
    get_tree().quit()

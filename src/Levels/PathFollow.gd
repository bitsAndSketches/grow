extends PathFollow

func get_input():
	return (Input.get_action_strength("move_right") - Input.get_action_strength("move_left")) * 10
		
func _process(delta: float) -> void:
	set_offset(get_offset() + get_input() * delta)

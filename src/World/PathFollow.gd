extends PathFollow

func get_input():
	return (Input.get_action_strength("move_up") - Input.get_action_strength("move_down")) * 10
		
func _process(delta: float) -> void:
	set_offset(get_offset() + get_input() * delta)

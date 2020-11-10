extends Camera

export var speed = 4
export var max_offset = 40;

func slide(direction, delta: float) -> void:
	if abs(transform.origin.x) < max_offset:
		if direction == "right":
			transform.origin.x += speed * delta
		else:
			transform.origin.x += speed * delta

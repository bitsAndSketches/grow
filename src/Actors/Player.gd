extends KinematicBody

const FLOOR_NORMAL = Vector3.UP

export var gravity = Vector3.DOWN * 100
export var speed = 100

var velocity = Vector3.ZERO
onready var previous_x = transform.origin.x

onready var z_position = transform.origin.z

func get_input() -> Vector3:
	return Vector3(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		0,
		0
	)

func _physics_process(delta: float) -> void:
	velocity = get_input() * speed
	velocity += gravity * delta
	velocity = move_and_slide(velocity, FLOOR_NORMAL)
	transform.origin.z = z_position
	if abs(velocity.x) < 1:
		transform.origin.x = previous_x
	previous_x = transform.origin.x

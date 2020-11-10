extends KinematicBody

const FLOOR_NORMAL = Vector3.UP

export var speed = 100

var velocity = Vector3.ZERO
var move_mode = "lateral"
var gravity = Vector3.DOWN * 12

onready var previous_x = transform.origin.x
onready var z_position = transform.origin.z

func get_input() -> Vector3:
	var new_vel = Vector3.ZERO
	new_vel.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if move_mode == "vertical":
		new_vel.y = Input.get_action_strength("move_up") - Input.get_action_strength("move_down")
	return new_vel

func _physics_process(delta: float) -> void:
	velocity = get_input() * speed
	velocity += gravity
	velocity = move_and_slide(velocity, FLOOR_NORMAL)

#	Lock z position
	transform.origin.z = z_position
	
	var space_state = get_world().direct_space_state
	var ground = space_state.intersect_ray(global_transform.origin, Vector3(0, -60, 0))
	var x_offset = 10 if ground else -5
	var wall_right = space_state.intersect_ray(global_transform.origin, Vector3(45, x_offset, 0))
	var wall_left = space_state.intersect_ray(global_transform.origin, Vector3(-45, x_offset, 0))
	if wall_right or wall_left:
		gravity = Vector3.ZERO
		move_mode = "vertical"
	else:
		gravity = Vector3.DOWN * 12
		move_mode = "lateral"

	
#	To avoid weird movements on tiny slopes
	if abs(velocity.x) < 2:
		transform.origin.x = previous_x
#	if move_mode == "lateral":
#		global_transform.origin.y = min(global_transform.origin.y, ground.position.y + 45)
#	if move_mode == "vertical" and wall_left:
#		global_transform.origin.x = min(global_transform.origin.x, ground.position.x + 45)
#	if move_mode == "vertical" and wall_right:
#		global_transform.origin.x = min(global_transform.origin.x, ground.position.x - 45)
	previous_x = transform.origin.x

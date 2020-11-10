extends KinematicBody

const FLOOR_NORMAL = Vector3.UP

export var speed = 100
export var gravity_strength = 6

var velocity = Vector3.ZERO
var gravity = Vector3.DOWN * gravity_strength
var can_move_up = false

onready var previous_x = transform.origin.x
onready var z_position = transform.origin.z

func get_input() -> Vector3:
	var new_vel = Vector3.ZERO
	new_vel.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if can_move_up:
		new_vel.y = Input.get_action_strength("move_up") - Input.get_action_strength("move_down")
	return new_vel

func _physics_process(delta: float) -> void:
	velocity = get_input() * speed
	velocity += gravity
	velocity = move_and_slide(velocity, FLOOR_NORMAL)

#	Lock z position
	transform.origin.z = z_position
	
	var space_state = get_world().direct_space_state
	var ground = space_state.intersect_ray(global_transform.origin, Vector3(0, -50, 0))
	var x_offset = 10 if ground else -30
	var wall_right = space_state.intersect_ray(global_transform.origin, Vector3(50, x_offset, 0))
	var wall_left = space_state.intersect_ray(global_transform.origin, Vector3(-50, x_offset, 0))
	can_move_up = wall_right or wall_left
	if wall_right or wall_left:
		gravity = Vector3.ZERO
	else:
		gravity = Vector3.DOWN * gravity_strength
	
#	To avoid weird movements on tiny slopes
	if abs(velocity.x) < 2:
		transform.origin.x = previous_x
	previous_x = transform.origin.x

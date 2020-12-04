extends KinematicBody

const FLOOR_NORMAL = Vector3.UP

export var speed = 12
export var gravity_strength = 100

var velocity = Vector3.ZERO
var gravity = Vector3.DOWN * gravity_strength
var mode = "free"

onready var previous_x = transform.origin.x
onready var previous_y = transform.origin.y
onready var z_position = transform.origin.z

func get_input() -> Vector3:
	var new_vel = Vector3.ZERO
	new_vel.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	return new_vel

func set_mode(new_mode: String) -> void:
	mode = new_mode

func _physics_process(delta: float) -> void:
	if mode == "free":
#		global_transform.basis = Basis.IDENTITY
#		Lock z position
		global_transform.origin.z = 0
		velocity = get_input() * speed
		velocity += gravity * delta
		velocity = move_and_slide(velocity, FLOOR_NORMAL)

	if Input.is_action_pressed("ui_left") :
		get_node("AnimatedSprite3D").play("Left")
	elif Input.is_action_pressed("ui_right") :
		get_node("AnimatedSprite3D").play("Right")
	else :
		get_node("AnimatedSprite3D").play("Idle")
	
	#	To avoid weird movements on tiny slopes
#		if abs(velocity.x) < 2:
#			transform.origin.x = previous_x
#		previous_x = transform.origin.x

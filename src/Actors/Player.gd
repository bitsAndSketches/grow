extends KinematicBody

const FLOOR_NORMAL = Vector3.UP

export var gravity = Vector3.DOWN * 12
export var speed = 100

onready var velocity = Vector3.ZERO


func get_input() -> Vector3:
	return Vector3(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		0,
		0
	)

func _physics_process(delta: float) -> void:
	velocity += (gravity * delta)
	if is_on_floor():
		velocity = get_input() * speed
	velocity = move_and_slide(velocity, FLOOR_NORMAL)
	
	#Ajout pour l'animation du sprite du joueur
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		get_node("../Player/Character animated").play("Move left")
	else :
		get_node("../Player/Character animated").play("Idle")

extends KinematicBody2D

var velocity = Vector2.ZERO

export var gravity = Vector2(0, 800)
export var speed = 800

const FLOOR_NORMAL = Vector2.UP

const plant_scene_path = "res://src/plant.tscn"

var plant_scene = null
var last_plant_right = INF
var last_plant_left = -INF
var is_landed = false
export var spawn_offset = 32

func _ready() -> void:
	plant_scene = preload(plant_scene_path)

func get_input(initial_velocity: Vector2) -> Vector2:
	var new_velocity = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		initial_velocity.y
	)
	return new_velocity

func check_for_spawn() -> void:
	if is_on_floor() and not is_landed:
		is_landed = true
		spawn(position.x)
	elif is_on_floor() and (position.x - spawn_offset) > last_plant_right:
		spawn(last_plant_right + 32)
		
	elif is_on_floor() and (position.x + spawn_offset) < last_plant_left:
		spawn(last_plant_left - 32)

func spawn(x_pos: int):
		var plant = plant_scene.instance()
		plant.position.y = position.y + 6
		plant.position.x = x_pos
		get_parent().add_child(plant)
		last_plant_left = plant.position.x - 32
		last_plant_right = plant.position.x + 32
	
func _physics_process(delta: float) -> void:
	if is_on_floor():
		velocity = get_input(velocity) * speed
	check_for_spawn()
	velocity += gravity * delta
	velocity = move_and_slide(velocity, FLOOR_NORMAL)

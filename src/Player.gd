extends KinematicBody2D

const FLOOR_NORMAL = Vector2.UP
const plant_scene_path = "res://src/plant.tscn"

export var gravity = Vector2(0, 800)
export var speed = 800
export var spawn_offset = 32

var velocity = Vector2.ZERO
var plant_scene = null
var last_plant_right = -INF
var last_plant_left = +INF
var is_landed = false
var half_sprite = 0
var plant_container

func _ready() -> void:
	plant_scene = preload(plant_scene_path)
	var plant_ref = plant_scene.instance()
	half_sprite = (plant_ref.get_rect().size).x / 2
	plant_container = get_node("../Plant_container")

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
		spawn(last_plant_right + half_sprite)
		
	elif is_on_floor() and (position.x + spawn_offset) < last_plant_left:
		spawn(last_plant_left - half_sprite)

func spawn(x_pos: float):
		var plant: Sprite = plant_scene.instance()
		plant.position.y = position.y
		plant.position.x = x_pos
		get_parent().add_child_below_node(plant_container, plant)
		last_plant_left = plant.position.x - half_sprite
		last_plant_right = plant.position.x + half_sprite
	
func _physics_process(delta: float) -> void:
	if is_on_floor():
		velocity = get_input(velocity) * speed
	check_for_spawn()
	velocity += gravity * delta
	velocity = move_and_slide(velocity, FLOOR_NORMAL)

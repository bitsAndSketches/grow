extends KinematicBody

const FLOOR_NORMAL = Vector3.UP

export var gravity = Vector3.DOWN * 12
export var speed = 100
export var spawn_offset = 0.32

var last_plant_right = -INF
var last_plant_left = INF

onready var velocity = Vector3.ZERO
onready var is_landed = false
onready var	plant_scene = preload("res://src/Plants/Plant.tscn")
onready var plant_container = get_node("../PlantContainer")

var half_sprite = 0

func _ready() -> void:
	half_sprite = 0.32

func get_input() -> Vector3:
	return Vector3(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		0,
		0
	)

func check_for_spawn() -> void:
	var position_x= self.transform.origin.x
	if is_on_floor() and not is_landed:
		is_landed = true
		spawn(position_x)
	elif is_on_floor() and (position_x > last_plant_right):
		spawn(last_plant_right + half_sprite)
	elif is_on_floor() and (position_x < last_plant_left):
		spawn(last_plant_left - half_sprite)

func spawn(x_pos: float):
		var position_y = self.transform.origin.y
		var position_z = self.transform.origin.z
		var plant: Sprite3D = plant_scene.instance()
		plant.transform.origin.y = position_y
		plant.transform.origin.x = x_pos
		plant.transform.origin.z = position_z
		get_parent().add_child_below_node(plant_container, plant)
		if plant.transform.origin.x < last_plant_left:
			last_plant_left = plant.transform.origin.x - half_sprite
		if plant.transform.origin.x > last_plant_right:
			last_plant_right = plant.transform.origin.x + half_sprite 

func _physics_process(delta: float) -> void:
	check_for_spawn()
	velocity += (gravity * delta)
	if is_on_floor():
		velocity = get_input() * speed
	velocity = move_and_slide(velocity, FLOOR_NORMAL)

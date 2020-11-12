extends Spatial

export var spawn_offset = 2.5

var last_plant_right = -INF
var last_plant_left = INF

onready var velocity = Vector3.ZERO
onready var is_landed = false
onready var	plant_scene = preload("res://assets/Assets 2D/Root 1/Root 1.tscn")
onready var plant_container = get_node("../PlantContainer")

var half_sprite = 2.5

func _ready() -> void:
	half_sprite = spawn_offset

func check_for_spawn() -> void:
	var position_x= get_node("../Player").transform.origin.x
	if get_node("../Player").is_on_floor() and not is_landed:
		is_landed = true
		spawn(position_x)
	elif get_node("../Player").is_on_floor() and (position_x > last_plant_right):
		spawn(last_plant_right + half_sprite)
	elif get_node("../Player").is_on_floor() and (position_x < last_plant_left):
		spawn(last_plant_left - half_sprite)
		
func spawn(x_pos: float):
	var position_y = get_node("../Player").transform.origin.y
	var position_z = get_node("../Player").transform.origin.z
	var plant: AnimatedSprite3D = plant_scene.instance()
	plant.play("grow")
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

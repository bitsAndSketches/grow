tool
extends Spatial

export var spawn_offset = 2.5

var last_plant_right = -INF
var last_plant_left = INF

onready var velocity = Vector3.ZERO
onready var is_landed = false
onready var	plant_scene = [preload("res://assets/Assets 3D/Growing weed.tscn"), preload("res://assets/Assets 3D/Growing grass.tscn")]
onready var plant_container = get_node("../PlantContainer")

var half_sprite = 2.5

func _ready() -> void:
	half_sprite = spawn_offset

func check_for_spawn() -> void:
	var position_x = get_node("../Player").transform.origin.x
	var position_y = get_node("../Player").transform.origin.y
	if get_node("../Player").is_on_floor() and not is_landed:
		is_landed = true
		spawn(position_x, position_y)
	elif get_node("../Player").is_on_floor() and (position_x > last_plant_right):
		spawn(last_plant_right + half_sprite, position_y)
	elif get_node("../Player").is_on_floor() and (position_x < last_plant_left):
		spawn(last_plant_left - half_sprite, position_y)
		
func spawn(x_pos: float, y_pos: float):
	var random_plant = randi()%2
	var position_y = get_node("../Player").transform.origin.y
	var position_z = get_node("../Player").transform.origin.z
	print(random_plant)
	var plant = plant_scene[random_plant].instance()
	if random_plant == 0 :
		plant.get_child(1).play("Armature001Action001")
	plant.transform.origin.y = y_pos - 0.4 + rand_range(-0.1,0.1)
	plant.transform.origin.x = x_pos
	plant.transform.origin.z = position_z + rand_range(-1.0, 1.0)
	var scale_variation = rand_range(-0.2, -0.1)
	plant.scale.x = plant.scale.x + scale_variation
	plant.scale.z = plant.scale.z + scale_variation
	plant.scale.y = plant.scale.y + scale_variation
	get_parent().add_child_below_node(plant_container, plant)
	if plant.transform.origin.x < last_plant_left :
		last_plant_left = plant.transform.origin.x
	if plant.transform.origin.x > last_plant_right :
		last_plant_right = plant.transform.origin.x

func _physics_process(delta: float) -> void:
	check_for_spawn()

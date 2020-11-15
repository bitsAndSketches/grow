extends Spatial

var rotate_velocity_x = 0.02
var rotate_velocity_y = 0.02
var rotate_velocity_z = 0.02
var amplitude_movement = 0.005
var speed_movement = 0.000005
var lfo_x
var lfo_y
var lfo_z
var rand_lfo_x = rand_range(-10000, 10000)
var rand_lfo_y = rand_range(-10000, 10000)
var rand_lfo_z = rand_range(-10000, 10000)

func _ready():
	pass # Replace with function body.

func _process(delta):
	lfo_x = cos((OS.get_ticks_msec() - rand_lfo_x) * 0.000005) * amplitude_movement
	lfo_y = cos((OS.get_ticks_msec() - rand_lfo_y) * 0.000005) * amplitude_movement
	lfo_z = cos((OS.get_ticks_msec() - rand_lfo_z) * 0.000005) * amplitude_movement
	
	rotate_velocity_y = cos((OS.get_ticks_msec() - rand_lfo_x) * speed_movement) * lfo_x
	rotate_velocity_x = cos((OS.get_ticks_msec() - rand_lfo_y) * speed_movement) * lfo_y
	rotate_velocity_z = cos((OS.get_ticks_msec() - rand_lfo_z) * speed_movement) * lfo_z
	self.rotate(Vector3(1,0,0), rotate_velocity_x)
	self.rotate(Vector3(0,1,0), rotate_velocity_y)
	self.rotate(Vector3(0,0,1), rotate_velocity_z)

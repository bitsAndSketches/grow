extends OmniLight

var amplitude_movement = 3
var speed_movement = 0.000005
var lfo
var oscillation
var min_light = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	lfo = cos(OS.get_ticks_msec() * speed_movement) * 0.0005
	oscillation = abs(cos(OS.get_ticks_msec() * lfo) * amplitude_movement)
	if oscillation < min_light :
		self.light_energy = min_light
	else :
		self.light_energy = oscillation


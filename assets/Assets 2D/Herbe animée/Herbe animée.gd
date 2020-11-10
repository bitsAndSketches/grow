extends AnimatedSprite3D

var nb_herbes = 0
var herbes = {}
var max_weed_in_area = 6

func spawn_weed ():
	
	var herbe_base = preload("res://Assets/Assets 2D/Herbe animée/Herbe animée.tscn")
	var herbe_key = "Herbe " + str(nb_herbes)
	herbes[herbe_key] = herbe_base.instance()
	get_node("..").add_child(herbes[herbe_key])
	var posX = get_node("../Character/MeshInstance").global_transform.origin.x + rand_range(0, 4)
	var posY = get_node("../Character/MeshInstance").global_transform.origin.y + rand_range(-0.1, 0)
	var posZ = get_node("../Character/MeshInstance").global_transform.origin.z + rand_range(-1, 1)
	herbes[herbe_key].transform.origin = Vector3(posX, posY, posZ)
	print(herbes)
	nb_herbes += 1
	

func _physics_process(delta):
	
	var count = 0
	var herbe_key = "Herbe " + str(nb_herbes)
	for i in herbes :
		if (herbes[i].global_transform.origin.x - get_node("../Character/MeshInstance").global_transform.origin.x) < 4 :
			count += 1
			
	if count < max_weed_in_area:
		spawn_weed()

extends Spatial

var Plant_dict = {}
var plant_in_range = {}
var plant_not_in_range = {}

func _ready():
	
	var Plant_container = get_node("Plants")
	var Plants_number = Plant_container.get_child_count()
	var This_plant = {}
	
	#Stores the plants in a dictionary
	for i in range(Plants_number) :
		This_plant[i] = Plant_container.get_child(i)
		i = i + 1
		
	# Reparent the plant to a new spatial node and create an animation for this spatial
	for i in range(Plants_number) :
		# Creation of a spatial node to reset the scaling value
		var a = Spatial.new()
		var Spatial_name = "Spatial" + str(i)
		a.name = Spatial_name
		a.transform.origin = This_plant[i].transform.origin
		Plant_container.remove_child(This_plant[i])
		
		# Debug Mesh to see where the plant is
#		var Debug_mesh = MeshInstance.new()
#		Debug_mesh.mesh = SphereMesh.new()
#		Debug_mesh.transform.origin = a.transform.origin
#		a.add_child(Debug_mesh)
#		a.get_child(0).transform.origin = Vector3(0, 0, 0)
		
		# Adding the plant mesh to the spatial node
		Plant_container.add_child(a)
		a.add_child(This_plant[i])
		a.get_child(0).transform.origin = Vector3(0, 0, 0)
		# Assigning animation
		a.get_child(0).add_child(AnimationPlayer.new())
		a.get_child(0).get_child(0).add_animation("Growth", load("res://assets/Assets 3D/Animations/Growth.tres"))
		a.get_child(0).get_child(0).add_animation("Fade", load("res://assets/Assets 3D/Animations/Fade.tres"))
		a.get_child(0).get_child(0).add_animation("Idle", load("res://assets/Assets 3D/Animations/Idle.tres"))
		a.get_child(0).get_child(0).add_animation("None", load("res://assets/Assets 3D/Animations/None.tres"))	
		#a.scale = Vector3(0, 0, 0)
		Plant_dict[i] = a
		i = i + 1
	for i in Plant_dict.values() :
		plant_not_in_range[i] = i

func Plants_in_range(dictionary):
	for i in dictionary.values() :
		var pos_plant
		pos_plant = i.global_transform.origin.x
		if pos_plant > get_node("../Player").global_transform.origin.x :
			if i in plant_in_range :
				pass
			else :
				plant_in_range[i] = i
				plant_not_in_range.erase(i)
				i.get_child(0).get_child(0).play("Growth")
				i.get_child(0).get_child(0).queue("Idle")
		else :
			if i in plant_not_in_range :
				pass
			else :
				plant_not_in_range[i] = i
				plant_in_range.erase(i)
				i.get_child(0).get_child(0).play("Fade")
				i.get_child(0).get_child(0).queue("None")

func _process(delta):
	Plants_in_range(Plant_dict)

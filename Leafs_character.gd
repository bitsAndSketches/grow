extends Node

var leafs = {}
var leaf_life_count = {}
var nb_leafs
var max_leafs = 10
var rotation_speed = 5
var lifetime = 500
var rand_factor = 0.2

func _physics_process(delta):
	if leafs.size() < max_leafs :
		spawn_leafs()
	
	#leaf_lifetime()


func spawn_leafs () :
	var this_leaf = preload("res://assets/Assets 2D/Weed 1/Weed 1.tscn").instance()
	leaf_life_count["leaf_count_" + str(leaf_life_count.size() + 1)] = lifetime
	leafs["leaf" + str(leafs.size() + 1)] = this_leaf
	self.add_child(this_leaf)
	var scale_ratio = rand_range(0.10, 0.20)
	this_leaf.scale.x = scale_ratio
	this_leaf.scale.y = scale_ratio
	this_leaf.transform = this_leaf.global_transform.rotated(Vector3(1,0,0), rand_range(0 , 50))
	leafs["leaf" + str(leafs.size())].global_transform.origin.x = self.global_transform.origin.x + rand_range(-rand_factor, rand_factor)
	leafs["leaf" + str(leafs.size())].global_transform.origin.y = self.global_transform.origin.y + rand_range(-rand_factor, rand_factor)
	leafs["leaf" + str(leafs.size())].global_transform.origin.z = self.global_transform.origin.z + rand_range(-rand_factor, rand_factor)
	
func leaf_lifetime() :
	for i in leafs.size() :
		if leaf_life_count["leaf_count_" + str(i + 1)] == 0 :
			self.remove_child(leafs["leaf" + str(leafs.size())])
			leafs.erase("leaf" + str(leafs.size()))
			spawn_leafs()		
		else :
			leaf_life_count["leaf_count_" + str(i + 1)] = leaf_life_count["leaf_count_" + str(i + 1)] - 1

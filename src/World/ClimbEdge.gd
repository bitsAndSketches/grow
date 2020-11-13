extends Area

export var is_end: bool = false

onready var path_follow = get_node("../Path/PathFollow")
onready var player_scene = preload("res://src/Actors/Player.tscn")

var is_player_on = false
var player = null

func _on_climb_edge_body_entered(body: Node) -> void:
	if body.name == "Player":
		is_player_on = true
		player = body

func _on_climb_edge_body_exited(body: Node) -> void:
	if body.name == "Player":
		is_player_on = false
		player = null

func _input(event: InputEvent) -> void:
	if is_player_on and event.is_action_released("action"):
		if player.mode == "free":
			print (Basis.IDENTITY)
			get_parent().remove_child(player)
			if player:
				player.queue_free()
			var new_player = player_scene.instance()
			new_player.set_mode("constrained")
			new_player.transform.origin = Vector3.ZERO
#			new_player.transform.basis = Basis.IDENTITY
			if is_end:
				path_follow.set_unit_offset(1)
			else:
				path_follow.set_unit_offset(0)
			path_follow.add_child(new_player)
		else:
			var transform = player.get_global_transform()
			path_follow.remove_child(player)
			if player:
				player.queue_free()
			var new_player = player_scene.instance()
			new_player.set_mode("free")
			get_parent().add_child(new_player)
			new_player.global_transform = $ReleasePosition.global_transform
			new_player.transform.basis = Basis.IDENTITY

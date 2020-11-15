extends Area

var player = null

onready var path_follow = get_node("../Path/PathFollow")
onready var player_scene = preload("res://src/Actors/Player.tscn")

func _on_ClimbStart_body_entered(body: Node) -> void:
	if body.name == "Player":
		player = body
		

func _on_ClimbStart_body_exited(body: Node) -> void:
	if body.name == "Player":
		player = null

func _input(event: InputEvent) -> void:
	if player and event.is_action_released("action"):
		if player.mode == "free":
			get_parent().remove_child(player)
			var new_player = player_scene.instance()
			player = new_player
			player.set_mode("constrained")
			player.transform.origin = Vector3.ZERO
			path_follow.set_offset(0)
			path_follow.add_child(player)
		else:
			path_follow.remove_child(player)
			var new_player = player_scene.instance()
			player = new_player
			player.set_mode("free")
			player.global_transform.origin = $StartPosition.transform.origin
			get_parent().add_child(player)

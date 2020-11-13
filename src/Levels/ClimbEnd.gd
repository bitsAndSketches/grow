extends Area

var player = null
var is_player_on

onready var path_follow = get_node("../Path/PathFollow")
onready var player_scene = preload("res://src/Actors/Player.tscn")

func _on_ClimbEnd_body_entered(body: Node) -> void:
	if body.name == "Player":
		player = body
		is_player_on = true

func _on_ClimbEnd_body_exited(body: Node) -> void:
	if body.name == "Player":
		player = null
		is_player_on = false

func _input(event: InputEvent) -> void:
	if event.is_action_released("action"):
		print(is_player_on)
		if is_player_on:
			if player.mode == "free":
				get_parent().remove_child(player)
				var new_player = player_scene.instance()
				player = new_player
				player.set_mode("constrained")
				player.transform.origin = Vector3.ZERO
				path_follow.set_offset(8.2)
				path_follow.add_child(player)
			else:
				path_follow.remove_child(player)
				var new_player = player_scene.instance()
				player = new_player
				player.set_mode("free")
				player.global_transform.origin = $EndPosition.transform.origin
				get_parent().add_child(player)

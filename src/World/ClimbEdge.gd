extends Area

export var is_end: bool = false
export var helper_node: NodePath

onready var path_follow = get_node("../Path/PathFollow")
onready var helper = get_node(helper_node)
onready var player_scene = preload("res://src/Actors/Player.tscn")

var is_player_on = false
var player = null

func _on_climb_edge_body_entered(body: Node) -> void:
	if body.name == "Player":
		is_player_on = true
		player = body
		helper.show_helper(player.mode)

func _on_climb_edge_body_exited(body: Node) -> void:
	if body.name == "Player":
		is_player_on = false
		player = null
		helper.hide()

func _input(event: InputEvent) -> void:
	if is_player_on and event.is_action_released("action"):
		player.queue_free()
		var new_player = player_scene.instance()
		new_player.set_mode("constrained" if player.mode == "free" else "free")
		if new_player.mode == "constrained":
			new_player.transform.origin = Vector3.ZERO
			if is_end:
				path_follow.set_unit_offset(1)
			else:
				path_follow.set_unit_offset(0)
			path_follow.add_child(new_player)
		else:
			get_parent().add_child(new_player)
			new_player.set_global_transform($ReleasePosition.get_global_transform())
		new_player.global_transform.basis = Basis.IDENTITY

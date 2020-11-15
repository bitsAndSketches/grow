extends Area


func _on_Climbable_body_entered(body: Node) -> void:
	if body.name == "Player":
		get_node("../../Player").set_is_on_climbable(true)


func _on_Climbable_body_exited(body: Node) -> void:
	if body.name == "Player":
		get_node("../../Player").set_is_on_climbable(false)

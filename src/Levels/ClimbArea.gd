extends Area

func _on_ClimbArea_body_entered(body: Node) -> void:
	print(body)
	if body.name == "Player":
		get_node("../../Player").gravity = Vector3.ZERO


func _on_ClimbArea_body_exited(body: Node) -> void:
	print(body)
	if body.name == "Player":
		get_node("../../Player").gravity = Vector3.DOWN * 100

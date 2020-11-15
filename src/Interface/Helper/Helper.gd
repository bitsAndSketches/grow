extends VBoxContainer

func _ready() -> void:
	hide()

func show_helper(mode: String):
	show()
	match mode:
		"constrained":
			$Label.text = "Release"
		"free":
			$Label.text = "Climb"

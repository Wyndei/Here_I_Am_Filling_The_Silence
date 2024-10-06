extends ColorRect


func _unhandled_input(event):
	if event is InputEventKey:
		if Input.is_action_just_pressed("Chromatic_Aberration_Toggle"):
			visible = !visible

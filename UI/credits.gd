extends Control




func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	MusicHandler.play()

func _on_close_pressed():
	get_tree().quit()

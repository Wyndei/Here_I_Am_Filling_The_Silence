extends Control


@export var ap : Node

var open : bool = false

var flag_count : int = 0


func _ready():
	pass


func _unhandled_input(_event):
	if !get_tree().paused:
		if Input.is_action_just_pressed("Pause"):
			open = true


func _physics_process(_delta):
	if open:
		get_tree().paused = true
		show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	else:
		
		hide()


func _on_resume_pressed():
	open = false
	get_tree().paused = false


func _on_quit_pressed():
	if flag_count < 6:
		open = false
		ap.play("Asleepen")
		get_tree().paused = false
	elif flag_count >= 6:
		open = false
		ap.play("Asleepen_End")
		get_tree().paused = false

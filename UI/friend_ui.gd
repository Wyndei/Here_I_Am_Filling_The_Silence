extends Control


@onready var friend_container = $FriendContainer

@onready var talk_tutorial = $TalkTutorial
@onready var error_label = $ErrorLabel
@onready var speaking_label = $SpeakingLabel

@onready var warning_timer = $Timers/WarningTimer

@onready var questions = $Questions


func _ready():
	questions.hide()
	talk_tutorial.show()
	for child in friend_container.get_children():
		child.show()


func _physics_process(_delta):
	if questions.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED



func gain_friend(friend : Friend):
	for child in friend_container.get_children():
		if child.friend == friend:
			child.show()


func _unhandled_input(_event):
	if Input.is_action_just_pressed("Talk"):
		questions.show()
		
		talk_tutorial.hide()
		


func _on_warning_timer_timeout():
	error_label.hide()
	speaking_label.hide()

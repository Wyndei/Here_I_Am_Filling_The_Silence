extends CanvasLayer

@export var screen_friend : Node

var friend : Friend

var open : bool = false

@onready var question_container = $QuestionContainer



func _ready():
	friend = get_parent().friend

func _process(_delta):
	if open:
		get_tree().paused = true
		question_container.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	else:
		get_tree().paused = false
		question_container.hide()


func _on_button_1_pressed():
	AnswerPlayer.stream = friend.responses[0]
	AnswerPlayer.play()
	open = false


func _on_button_5_pressed():
	AnswerPlayer.stream = friend.responses[1]
	AnswerPlayer.play()
	open = false


func _on_button_7_pressed():
	AnswerPlayer.stream = friend.responses[2]
	AnswerPlayer.play()
	open = false


func _on_button_8_pressed():
	AnswerPlayer.stream = friend.responses[3]
	AnswerPlayer.play()
	open = false


func _on_button_10_pressed():
	AnswerPlayer.stream = friend.responses[4]
	AnswerPlayer.play()
	open = false


func _on_nevermind_pressed():
	open = false
	FriendUI.hide_friends()
	get_parent().show_friend()

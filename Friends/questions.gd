extends CanvasLayer

@export var screen_friend : Node

var friend : Friend

var open : bool = false

@onready var question_container = $QuestionContainer





func _ready():
	friend = get_parent().friend

func _physics_process(_delta):
	if open:
		get_tree().paused = true
		question_container.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	else:
		question_container.hide()


func _on_button_1_pressed():
	AnswerPlayer.stream = friend.responses[0]
	AnswerPlayer.play()
	open = false
	get_tree().paused = false

func _on_button_2_pressed():
	AnswerPlayer.stream = friend.responses[1]
	AnswerPlayer.play()
	open = false
	get_tree().paused = false
	
func _on_button_3_pressed():
	AnswerPlayer.stream = friend.responses[2]
	AnswerPlayer.play()
	open = false
	get_tree().paused = false

func _on_button_4_pressed():
	AnswerPlayer.stream = friend.responses[3]
	AnswerPlayer.play()
	open = false
	get_tree().paused = false

func _on_button_5_pressed():
	AnswerPlayer.stream = friend.responses[4]
	AnswerPlayer.play()
	open = false
	get_tree().paused = false

func _on_button_6_pressed():
	AnswerPlayer.stream = friend.responses[5]
	AnswerPlayer.play()
	open = false
	get_tree().paused = false


func _on_button_7_pressed():
	AnswerPlayer.stream = friend.responses[6]
	AnswerPlayer.play()
	open = false
	get_tree().paused = false


func _on_button_8_pressed():
	AnswerPlayer.stream = friend.responses[7]
	AnswerPlayer.play()
	open = false
	get_tree().paused = false

func _on_button_9_pressed():
	AnswerPlayer.stream = friend.responses[8]
	AnswerPlayer.play()
	open = false
	get_tree().paused = false

func _on_button_10_pressed():
	AnswerPlayer.stream = friend.responses[9]
	AnswerPlayer.play()
	open = false
	get_tree().paused = false

func _on_button_11_pressed():
	AnswerPlayer.stream = friend.responses[10]
	AnswerPlayer.play()
	open = false
	get_tree().paused = false

func _on_button_12_pressed():
	AnswerPlayer.stream = friend.responses[11]
	AnswerPlayer.play()
	open = false
	get_tree().paused = false


func _on_nevermind_pressed():
	open = false
	FriendUI.hide_friends()
	get_parent().show_friend()
	get_tree().paused = false

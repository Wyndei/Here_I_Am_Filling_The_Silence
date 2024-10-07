extends Node3D


@onready var friend_container = $FriendContainer

@onready var error_label = $ErrorLabel


@onready var speech_bubble = $SpeechBubble


func _process(_delta):
	if AnswerPlayer.playing:
		speech_bubble.show()
	else:
		speech_bubble.hide()


func _ready():
	speech_bubble.play("Speech")
	AnswerPlayer.audio_finished.connect(hide_friends)
	
	hide_friends()


func show_friend(friend : Friend):
	for child in friend_container.get_children():
		if child.friend == friend:
			child.show()
	
	


func hide_friends():
	for child in friend_container.get_children():
		child.hide()
	
	

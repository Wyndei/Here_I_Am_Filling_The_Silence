extends Node3D


@onready var friend_container = $FriendContainer

@onready var error_label = $ErrorLabel
@onready var speaking_label = $SpeakingLabel

@onready var warning_timer = $Timers/WarningTimer



func _ready():
	
	AnswerPlayer.audio_finished.connect(hide_friends)
	
	hide_friends()


func show_friend(friend : Friend):
	for child in friend_container.get_children():
		if child.friend == friend:
			child.show()


func hide_friends():
	for child in friend_container.get_children():
		child.hide()

extends StaticBody3D

@onready var questions : Node = $Questions


@onready var music_player = $MusicPlayer
@onready var sand_sound = $SandSound


@export var friend : Friend
@onready var collision = $Collision

@onready var speaking_label = $SpeakingLabel
@onready var speaking_timer = $SpeakingLabel/Timers/SpeakingTimer


var talking : bool = false

func _ready():
	AnswerPlayer.audio_finished.connect(show_friend)
	
	music_player.stream = friend.music
	music_player.play(MusicHandler.time)


func interact(_target : Node) -> void:
	
	if AnswerPlayer.playing:
		speaking_label.show()
		speaking_timer.start()
	else:
		_target.gain_friend(friend)
		talking = true
		questions.open = true
		collision.disabled = true
		hide()
		FriendUI.show_friend(friend)
		music_player.stop()


func show_friend():
	
	talking = false
	collision.disabled = false
	questions.open = false
	sand_sound.play()
	show()


func _on_speaking_timer_timeout():
	speaking_label.hide()

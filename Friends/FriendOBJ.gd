extends StaticBody3D

@onready var questions : Node = $Questions


@onready var music_player = $MusicPlayer
@onready var sand_sound = $SandSound


@export var friend : Friend
@onready var collision = $Collision

var talking : bool = false

func _ready():
	AnswerPlayer.audio_finished.connect(show_friend)
	
	music_player.stream = friend.music
	music_player.play(MusicHandler.time)


func interact(_target : Node) -> void:
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

extends StaticBody3D

@export var friend : Friend

func interact(_target : Node) -> void:
	_target.gain_friend()

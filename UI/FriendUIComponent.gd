extends Node3D

@export var mesh : Node

@export var friend : Friend

var time : float = 0.0
func _process(delta):
	time += delta
	
	mesh.position.y = sin(time)*0.05
	mesh.rotation.y = sin(time *0.5) * 0.25

extends StaticBody3D

@export var seen : bool = false

@export var player : Node

func _ready():
	player = get_tree().get_first_node_in_group("Player")

func _physics_process(_delta):
	if global_position.distance_to(player.global_position) >= 20 and seen:
		queue_free()


func _on_player_check_body_entered(body):
	if body.is_in_group("Player"):
		seen = true

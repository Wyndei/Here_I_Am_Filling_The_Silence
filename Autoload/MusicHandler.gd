extends Node



var cur_index : int = 0

var time : float = 0.0 
func _physics_process(delta):
	time += delta
	time = fmod(time,88.62)



func add_track():
	var music_player = get_child(cur_index)
	music_player.play(time)
	
	
	cur_index += 1

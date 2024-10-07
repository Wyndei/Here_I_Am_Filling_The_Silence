extends AudioStreamPlayer3D


func rand_pitch(audio : AudioStream ,_min : float, _max : float) -> void:
	stream = audio
	pitch_scale = randf_range(_min,_max)
	play()

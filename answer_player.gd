extends AudioStreamPlayer

signal audio_finished()



func _on_finished():
	audio_finished.emit()

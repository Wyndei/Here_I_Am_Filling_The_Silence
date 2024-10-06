extends GridContainer

@onready var characters = [$Character1, $Character2, $Character3, $Character4, $Character5, $Character6]

func _ready() -> void:
	CollectCharacter(0)
	characters[0].SetText("This is a test message.")

func CollectCharacter(index):
	characters[index].visible = true
	characters[index].SetText("");
	print("character collected")

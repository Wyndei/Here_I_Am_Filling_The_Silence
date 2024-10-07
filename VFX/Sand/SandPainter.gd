extends SubViewport


@export var worldextents : Rect2

@export var player : Node

@onready var sand_paintbrush = $SandPaintbrush
@onready var clear_brush = $ClearBrush

func _ready():
	sand_paintbrush.scale /= worldextents.size/3.5
	clear_brush.scale = sand_paintbrush.scale*2.0
	
	
	if not player:
		set_process(false)

func _process(_delta):
	
	var half_world_extents = worldextents.size * 0.5
	var player_pos = Vector2(wrapf(player.position.x,-25.0,25.0), wrapf(player.position.z,-25.0,25.0))
	
	player_pos += half_world_extents
	var paintbrush_position = player_pos / worldextents.size
	
	clear(paintbrush_position)
	
	sand_paintbrush.position = paintbrush_position * Vector2(size.x, size.y)
	
	#brought out the hodgepodge
	var playerHeight = player.position.y
	
	if playerHeight > 1.0:
		sand_paintbrush.visible = false
	else:
		sand_paintbrush.visible = true


func clear(_paintbrush_position):
	pass
	#await get_tree().create_timer(30.0).timeout
	#clear_brush.position = paintbrush_position * Vector2(size.x, size.y)

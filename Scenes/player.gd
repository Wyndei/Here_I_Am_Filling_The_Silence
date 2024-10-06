extends CharacterBody3D



signal friend_collected(friend : Friend)
signal distance_traveled(distance : float)



@export var speed = 3.0
@export var friction : float = 0.5


@export var mouse_sensitivity : float = 0.5



@onready var camera = $CameraPivot/Camera
@onready var animation_player = $CameraPivot/Camera/AnimationPlayer
@onready var look_cast = $CameraPivot/Camera/LookCast
@onready var friend_ui = $GUI/FriendUI

@onready var left_click = $GUI/left_click

var mouse_visible : bool = false


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if not mouse_visible:
			camera.rotate_x(deg_to_rad(-event.relative.y*mouse_sensitivity))
			rotate_y(deg_to_rad(-event.relative.x*mouse_sensitivity))
				
			camera.rotation.x = clamp(camera.rotation.x,-1.5,1.5)



func _physics_process(delta):
	if Input.is_action_just_pressed("Show_Mouse"):
		mouse_visible = !mouse_visible
	
	if !mouse_visible:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var input_dir = Input.get_vector("Left", "Right", "Forward", "Back")
	var direction = (camera.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = lerp(velocity.x,direction.x * speed,0.1)
		velocity.z = lerp(velocity.z,direction.z * speed,0.1)
	else:
		velocity.x = move_toward(velocity.x, 0, 0.5)
		velocity.z = move_toward(velocity.z, 0, 0.5)
	
	if direction:
		animation_player.play("Head_Bob")
	else:
		animation_player.play("Stand")
	
	
	move_and_slide()


func interact():
	var interact_with : Node = look_cast.get_collider(0)
	if interact_with.is_in_group("Interactable"):
		if Input.is_action_just_pressed("Interact"):
			interact_with.interact(self) 
	else:
		left_click.hide()
		
	
func gain_friend(friend : Friend):
	friend_ui.gain_friend(friend)
	friend_collected.emit(friend)

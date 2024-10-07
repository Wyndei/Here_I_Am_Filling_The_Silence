extends CharacterBody3D


signal distance_traveled(distance : float)
signal friend_collected(friend : Friend)

var speed = 3.0
@export var walk_speed = 3.0
@export var crouch_speed = 2.0
@export var friction : float = 0.5


@export var mouse_sensitivity : float = 0.5

@onready var camera = $CameraPivot/Camera
@onready var CameraAnim = $CameraPivot/Camera/CameraAnim
@onready var look_cast = $CameraPivot/Camera/LookCast
@onready var friend_ui = $GUI/FriendUI

@onready var left_click = $GUI/LeftClick

var crouched : bool = false

var mouse_visible : bool = false


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if not mouse_visible:
			camera.rotate_x(deg_to_rad(-event.relative.y*mouse_sensitivity))
			rotate_y(deg_to_rad(-event.relative.x*mouse_sensitivity))
				
			camera.rotation.x = clamp(camera.rotation.x,-1.5,1.5)


var position_buffer : Vector3 = Vector3(0.0,0.0,0.0)
func _physics_process(delta):
	
	
	
	interact()
	
	if Input.is_action_just_pressed("Show_Mouse"):
		mouse_visible = !mouse_visible
	
	if !mouse_visible:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	
	if Input.is_action_just_pressed("Crouch"):
		crouched = !crouched
	
	if crouched:
		speed = crouch_speed
	else:
		speed = walk_speed
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var input_dir = Input.get_vector("Left", "Right", "Forward", "Back")
	var direction = (global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = lerp(velocity.x,direction.x * speed,0.1)
		velocity.z = lerp(velocity.z,direction.z * speed,0.1)
	else:
		velocity.x = move_toward(velocity.x, 0, 0.5)
		velocity.z = move_toward(velocity.z, 0, 0.5)
	
	if direction:
		if crouched:
			CameraAnim.play("Crouch_Walk")
		else:
			CameraAnim.play("Walk")
	else:
		if crouched:
			CameraAnim.play("Crouch")
		else:
			CameraAnim.play("Stand")
	
	
	move_and_slide()
	
	
	if abs(global_position.x) > 50.0:
		if global_position.x > 50:
			global_position.x = -50
		if global_position.x < -50:
			global_position.x = 50
	
	if abs(global_position.z) > 50.0:
		if global_position.z > 50:
			global_position.z = -50
		if global_position.z < -50:
			global_position.z = 50
	
	
	if global_position != position_buffer:
		var distance : float = global_position.distance_to(position_buffer)
		distance_traveled.emit(distance)
		position_buffer = global_position



func interact():
	if look_cast.is_colliding():
		
		left_click.show()
		
		var interact_with : Node = look_cast.get_collider(0)
		if interact_with.is_in_group("Interactable"):
			if Input.is_action_just_pressed("Interact"):
				interact_with.interact(self) 
	else:
		left_click.hide()
		
	
func gain_friend(friend : Friend):
	friend_ui.gain_friend(friend)
	friend_collected.emit(friend)

extends Node

@export var player : Node

@onready var dist_label = $DistLabel


#flags

var fire_extinguisher : bool = false
var candle : bool = false
var book : bool = false
var car_door : bool = false
var router : bool = false
var mouse : bool = false

var flag_count : int = 0

const TREE = preload("res://Environment/Foliage/Tree/tree.tscn")

const FIRE_EXTINGUISHER = preload("res://Friends/FireExtinguisher/FireExtinguisher.tscn")
const CANDLE = preload("res://Friends/Candle/candle.tscn")
const BOOK = preload("res://Friends/Book/book.tscn")
const CAR_DOOR = preload("res://Friends/CarDoor/car_door.tscn")
const ROUTER = preload("res://Friends/Router/router.tscn")
const MOUSE = preload("res://Friends/Mouse/mouse.tscn")

var player_distance : float = 0.0


func _ready():
	player.friend_collected.connect(friend_found)

func _on_player_distance_traveled(distance : float):
	player_distance+=distance
	
	dist_label.text = "Distance: " + str(snappedf(player_distance,0.1)) 
	
	if player_distance >= 10 and !book:
		spawn_object(BOOK)
		#spawn_object(TREE) #doesn't spawn a tree, the tree has already been spawned
		book = true
	
	if player_distance >= 75 and flag_count >= 1 and !fire_extinguisher:
		spawn_object(FIRE_EXTINGUISHER)
		spawn_object(TREE)
		fire_extinguisher = true
	
	if player_distance >= 100 and flag_count >= 2 and !candle:
		spawn_object(CANDLE)
		spawn_object(TREE)
		candle = true
	
	if player_distance >= 150 and flag_count >= 3 and !mouse:
		spawn_object(MOUSE)
		spawn_object(TREE)
		mouse = true
	
	if player_distance >= 250 and flag_count >= 4 and !car_door:
		spawn_object(CAR_DOOR)
		spawn_object(TREE)
		car_door = true
	
	
	if player_distance >= 300 and flag_count >= 5 and !router:
		spawn_object(ROUTER)
		spawn_object(TREE)
		router = true
		
	
	if flag_count >= 6:
		MusicHandler.add_track()


func spawn_object(object : PackedScene):
	var object_instance = object.instantiate()
	
	add_child(object_instance)
	var object_position : Vector3 = Vector3(randi_range(-25,25),0,randi_range(-25,25))
	var object_rotation : float = randf_range(-180.0,180.0)
	
	while object_position.distance_to(player.global_position) < 15.0:
		print("position too close to player")
		object_position = Vector3(randi_range(-25,25),0,randi_range(-25,25))
		
	object_instance.global_position = object_position
	object_instance.rotation.y = object_rotation


func spawn_tree():
	pass

func friend_found(_friend : Friend):
	flag_count += 1

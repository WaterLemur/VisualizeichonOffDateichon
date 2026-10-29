#!museum.gd
extends Node


var cam_index = 0 as int
@onready var camera = $World/CameraRig/Camera3D as Camera3D

@onready var cam_pos_main_menu = $World/CameraRig/PosMainMenu          as Node3D
@onready var cam_pos_museum    = $World/CameraRig/PosMuseum            as Node3D

@onready var cam_pos_history  = $World/CameraRig/PosMuseum/PosHistory  as Node3D
@onready var cam_pos_artifact = $World/CameraRig/PosMuseum/PosArtifact as Node3D
@onready var cam_pos_graphs   = $World/CameraRig/PosMuseum/PosGraphs   as Node3D

@onready var cam_pos_options  = $World/CameraRig/PosOptions            as Node3D
@onready var cam_pos_info     = $World/CameraRig/PosInfo               as Node3D

@onready var cam_pos_exit     = $World/CameraRig/PosExit               as Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Persistent.set_scene_label("Museum")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _camera_transition(left: bool) -> void:
	if left: cam_index -= 1
	else:    cam_index += 1
	
	if cam_index < 1: cam_index = 7
	if cam_index > 7: cam_index = 1
	
	print("Museum: CameraTransition = %d" % cam_index)
	
	match cam_index:
		0: camera.transform = cam_pos_main_menu.transform
		1: camera.transform = cam_pos_museum.transform
		
		2: camera.transform = cam_pos_history.transform
		3: camera.transform = cam_pos_artifact.transform
		4: camera.transform = cam_pos_graphs.transform
		
		5: camera.transform = cam_pos_options.transform
		6: camera.transform = cam_pos_info.transform
		
		7: camera.transform = cam_pos_exit.transform

func _camera_smooth_transition(delta: float) -> void:
	pass


func _on_texture_button_left_pressed() -> void:
	print("Museum: Navigation = Left")
	_camera_transition(true)

func _on_texture_button_right_pressed() -> void:
	print("Museum: Navigation = Right")
	_camera_transition(false)

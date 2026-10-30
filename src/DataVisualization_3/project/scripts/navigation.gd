#!navigation.gd
extends Node


enum State_Main     { MAIN_MENU, GRAPHS, ARTIFACT, OPTIONS, EXIT }
enum State_Graph    { OFF, DATA_BASES, MAP, BARS, PIE, TENDENCY }
enum State_Artifact { OFF, FULL, WEIGHT, AMMOUNT, STYLUS }

var cam_index = 0 as int
var state_main:     State_Main     = State_Main.MAIN_MENU
var state_graph:    State_Graph    = State_Graph.OFF
var state_artifact: State_Artifact = State_Artifact.OFF

@onready var camera = $"../../World/CameraRig/MainCamera" as Camera3D

@onready var cam_pos_main_menu = $"../../World/CameraRig/PosMainMenu"          as Node3D
@onready var cam_pos_museum    = $"../../World/CameraRig/PosMuseum"            as Node3D

@onready var cam_pos_history  = $"../../World/CameraRig/PosMuseum/PosHistory"  as Node3D
@onready var cam_pos_artifact = $"../../World/CameraRig/PosMuseum/PosArtifact" as Node3D
@onready var cam_pos_graphs   = $"../../World/CameraRig/PosMuseum/PosGraphs"   as Node3D

@onready var cam_pos_options  = $"../../World/CameraRig/PosOptions"            as Node3D
@onready var cam_pos_info     = $"../../World/CameraRig/PosInfo"               as Node3D

@onready var cam_pos_exit     = $"../../World/CameraRig/PosExit"               as Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_camera_pos_main_menu()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
# ==========================================
# ============== STATE MACHINE =============
# ==========================================
func _state_machine() -> void:
	if(state_main   == State_Main.MAIN_MENU): pass
	elif(state_main == State_Main.GRAPHS):
		if(state_graph == State_Graph.DATA_BASES): pass
		elif(state_graph == State_Graph.MAP): pass
		elif(state_graph == State_Graph.BARS): pass
		elif(state_graph == State_Graph.PIE): pass
		elif(state_graph == State_Graph.TENDENCY): pass
	elif(state_main == State_Main.ARTIFACT):
		if(state_artifact == State_Artifact.FULL): pass
		elif(state_artifact == State_Artifact.WEIGHT): pass
		elif(state_artifact ==  State_Artifact.AMMOUNT): pass
		elif(state_artifact == State_Artifact.STYLUS): pass
	elif(state_main == State_Main.OPTIONS):   pass
	elif(state_main == State_Main.EXIT):      pass


func _camera_pos_main_menu() -> void:
	camera.transform = cam_pos_main_menu.transform
	
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

# ==========================================
# ============== NAVIGATION ================
# ==========================================
func _on_texture_button_left_pressed() -> void:
	print("Museum: Navigation = Left")
	_camera_transition(true)

func _on_texture_button_right_pressed() -> void:
	print("Museum: Navigation = Right")
	_camera_transition(false)
	
func _on_tb_up_pressed() -> void:
	print("Museum: Navigation = Up")
	
func _on_tb_down_pressed() -> void:
	print("Museum: Navigation = Down")

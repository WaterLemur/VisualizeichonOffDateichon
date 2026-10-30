#!navigation.gd
extends Node


enum State_Main     { MAIN_MENU, GRAPHS, ARTIFACT, OPTIONS, EXIT }
enum State_Graph    { OFF, DATA_BASES, MAP, BARS, PIE, TENDENCY }
enum State_Artifact { OFF, FULL, WEIGHT, AMMOUNT, STYLUS }

var cam_index = 0 as int

var state: StateNav
var state_main:     State_Main     = State_Main.MAIN_MENU
var state_graph:    State_Graph    = State_Graph.OFF
var state_artifact: State_Artifact = State_Artifact.OFF

@onready var camera = $"../../World/CameraRig/MainCamera" as Camera3D

@onready var pos_main_menu      = $"../../World/CameraRig/PosMainMenu"                 as Node3D
@onready var pos_rack_a         = $"../../World/CameraRig/PosRackA"                    as Node3D
@onready var pos_rack_b         = $"../../World/CameraRig/PosRackB"                    as Node3D
@onready var pos_db             = $"../../World/CameraRig/PosRackB/PosDataBases"       as Node3D
@onready var pos_map            = $"../../World/CameraRig/PosRackB/PosMap"             as Node3D
@onready var pos_graph_bars     = $"../../World/CameraRig/PosRackB/PosGraphBars"       as Node3D
@onready var pos_graph_pie      = $"../../World/CameraRig/PosRackB/PosGraphPies"       as Node3D
@onready var pos_graph_tendency = $"../../World/CameraRig/PosRackB/PosGraphTendencies" as Node3D
@onready var pos_options        = $"../../World/CameraRig/PosOptions"                  as Node3D
@onready var pos_info           = $"../../World/CameraRig/PosInfo"                     as Node3D
@onready var pos_exit           = $"../../World/CameraRig/PosExit"                     as Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_camera_pos_main_menu()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# ==========================================
# ============== STATE MACHINE =============
# ==========================================
func _camera_transition(left: bool) -> void:
	match state_main:
		State_Main.MAIN_MENU: pass
		State_Main.GRAPHS:
			match state_graph:
				State_Graph.DATA_BASES:
					state_graph = State_Graph.MAP
					_set_camera_pos(pos_map)


func _camera_pos_main_menu() -> void:
	camera.position = pos_main_menu.position

func _set_camera_pos(new_pos: Vector3) -> void:
	camera.position = new_pos
	

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

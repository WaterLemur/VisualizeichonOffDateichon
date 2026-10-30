#!navigation.gd
extends Node


enum Nav { LEFT, RIGHT, UP, DOWN }

enum State_Main     { MAIN_MENU, GRAPHS, ARTIFACT, OPTIONS, EXIT }
enum State_Graph    { OFF, DATA_BASES, MAP, BARS, PIE, TENDENCY }
enum State_Artifact { OFF, FULL, WEIGHT, AMMOUNT, STYLUS }

var cam_index = 0 as int

var state_main:     State_Main     = State_Main.MAIN_MENU
var state_graph:    State_Graph    = State_Graph.OFF
var state_artifact: State_Artifact = State_Artifact.OFF

@onready var camera = $"../../World/CameraRig/MainCamera" as Camera3D

@onready var pos_main_menu      = $"../../World/CameraRig/PosMainMenu"                 as Node3D
@onready var pos_museum         = $"../../World/CameraRig/PosMuseum"                   as Node3D
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
	set_camera_pos(pos_main_menu)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# ==========================================
# ============== STATE MACHINE =============
# ==========================================
func camera_transition(nav: Nav) -> void:
	match state_main:
		State_Main.MAIN_MENU: pass
		State_Main.GRAPHS:
			match state_graph:
				State_Graph.DATA_BASES:
					state_graph = State_Graph.MAP
					set_camera_pos(pos_map)
					

func set_camera_pos(new_pos: Node3D) -> void:
	print(camera.position)
	camera.position = new_pos.position
	print(camera.position)
	

func _camera_smooth_transition(delta: float) -> void:
	pass

# ==========================================
# ============== NAVIGATION ================
# ==========================================
func _on_texture_button_left_pressed() -> void:
	print("Museum: Navigation = Left")
	camera_transition(Nav.LEFT)

func _on_texture_button_right_pressed() -> void:
	print("Museum: Navigation = Right")
	camera_transition(Nav.RIGHT)
	
func _on_tb_up_pressed() -> void:
	print("Museum: Navigation = Up")
	camera_transition(Nav.UP)
	
func _on_tb_down_pressed() -> void:
	print("Museum: Navigation = Down")
	camera_transition(Nav.DOWN)

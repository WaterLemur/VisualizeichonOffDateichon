#!navigation.gd
extends Node


enum Nav { LEFT, RIGHT, UP, DOWN }

enum State_Main     { MAIN_MENU, HISTORY, MUSEUM, GRAPHS, ARTIFACT, OPTIONS, EXIT }
enum State_Rack    { ARTIFACT_PREVIEW, ARTIFACT, DATA_BASES, MAP, BARS, PIE, TENDENCY }
enum State_Artifact { FULL, WEIGHT, AMMOUNT, STYLUS }

var cam_index = 0 as int

var state_main:     State_Main     = State_Main.MAIN_MENU
var state_rack:     State_Rack     = State_Rack.DATA_BASES
var state_artifact: State_Artifact = State_Artifact.FULL

@onready var camera  = $"../../World/CameraRig/MainCamera" as Camera3D
@onready var museum  = $"../../World"                      as Node3D
@onready var sumer   = $"../../Sumer"                      as Sumer
@onready var ui      = $"../../UI/Menu"                    as Control

@onready var pos_main_menu      = $"../../World/CameraRig/PosMainMenu"               as Node3D
@onready var pos_museum         = $"../../World/CameraRig/PosMuseum"                 as Node3D
@onready var pos_rack_a         = $"../../World/CameraRig/PosRackA"                  as Node3D
@onready var pos_rack_b         = $"../../World/CameraRig/PosRackB"                  as Node3D
@onready var pos_db             = $"../../World/CameraRig/PosRackB/PosDataBases"     as Node3D
@onready var pos_map            = $"../../World/CameraRig/PosRackB/PosMap"           as Node3D
@onready var pos_graph_bars     = $"../../World/CameraRig/PosRackB/PosGraphBars"     as Node3D
@onready var pos_graph_pie      = $"../../World/CameraRig/PosRackB/PosGraphPies"     as Node3D
@onready var pos_graph_tendency = $"../../World/CameraRig/PosRackB/PosGraphTendency" as Node3D
@onready var pos_artifact       = $"../../World/CameraRig/PosArtifact"               as Node3D
@onready var pos_artifact_prev  = $"../../World/CameraRig/PosArtifactPrev"           as Node3D
@onready var pos_artifact_tuto  = $"../../World/CameraRig/PosArtifactTuto"           as Node3D
@onready var pos_art_weight     = $"../../World/CameraRig/PosArtifact/PosArtWeight"  as Node3D
@onready var pos_art_amount     = $"../../World/CameraRig/PosArtifact/PosArtAmount"  as Node3D
@onready var pos_options        = $"../../World/CameraRig/PosOptions"                as Node3D
@onready var pos_info           = $"../../World/CameraRig/PosInfo"                   as Node3D
@onready var pos_exit           = $"../../World/CameraRig/PosExit"                   as Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_camera_pos(pos_main_menu)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	"a"


# ==========================================
# ============== STATE MACHINE =============
# ==========================================
func camera_transition(nav: Nav) -> void:
	match state_rack:
		State_Rack.DATA_BASES:
			if nav == Nav.LEFT:
				museum.visible = false
				ui.visible = false
				sumer.show(true)
			
				state_rack = State_Rack.ARTIFACT_PREVIEW
				set_camera_pos(pos_artifact_prev)
				Persistent.set_scene_label("Artefacto - Funcionamiento")
				return
			if nav == Nav.RIGHT:
				state_rack = State_Rack.MAP
				set_camera_pos(pos_map)
				Persistent.set_scene_label("Mapa")
				return
		State_Rack.MAP:
			if nav == Nav.LEFT:
				state_rack = State_Rack.DATA_BASES
				set_camera_pos(pos_db)
				Persistent.set_scene_label("Base de datos")
				return
			if nav == Nav.RIGHT:
				state_rack = State_Rack.BARS
				set_camera_pos(pos_graph_bars)
				Persistent.set_scene_label("Barras")
				return
		State_Rack.BARS:
			if nav == Nav.LEFT:
				state_rack = State_Rack.MAP
				set_camera_pos(pos_map)
				Persistent.set_scene_label("Mapa")
				return
			if nav == Nav.RIGHT:
				state_rack = State_Rack.PIE
				set_camera_pos(pos_graph_pie)
				Persistent.set_scene_label("Torta")
				return
		State_Rack.PIE:
			if nav == Nav.LEFT:
				state_rack = State_Rack.BARS
				set_camera_pos(pos_graph_bars)
				Persistent.set_scene_label("Barras")
				return
			if nav == Nav.RIGHT:
				state_rack = State_Rack.TENDENCY
				set_camera_pos(pos_graph_tendency)
				Persistent.set_scene_label("Tendencia")
				return
		State_Rack.TENDENCY:
			if nav == Nav.LEFT:
				state_rack = State_Rack.PIE
				set_camera_pos(pos_graph_pie)
				Persistent.set_scene_label("Dona")
				return
			if nav == Nav.RIGHT:
				state_rack = State_Rack.ARTIFACT
				Persistent.set_scene_label("Artefacto")
				set_camera_pos(pos_artifact)
				return
		State_Rack.ARTIFACT:
			if nav == Nav.LEFT:
				state_rack = State_Rack.TENDENCY
				set_camera_pos(pos_graph_tendency)
				Persistent.set_scene_label("Tendencia")
				return
			if nav == Nav.RIGHT:
				museum.visible = false
				ui.visible = false
				sumer.show(true)
				
				state_rack = State_Rack.ARTIFACT_PREVIEW
				set_camera_pos(pos_artifact_prev)
				Persistent.set_scene_label("Artefacto - Funcionamiento")
				return
		State_Rack.ARTIFACT_PREVIEW:
			museum.visible = true
			ui.visible = true
			sumer.show(false)
				
			if nav == Nav.LEFT:
				state_rack = State_Rack.ARTIFACT
				Persistent.set_scene_label("Artefacto")
				set_camera_pos(pos_artifact)
				return
			if nav == Nav.RIGHT:
				state_rack = State_Rack.DATA_BASES
				set_camera_pos(pos_db)
				Persistent.set_scene_label("Base de datos")
				return


func set_camera_pos(new_pos: Node3D) -> void:
	print(camera.position)
	camera.global_transform = new_pos.global_transform
	print(camera.global_transform)
	

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
	print(state_rack)
	print(state_main)
	
func _on_btn_up_pressed() -> void:
	print("Museum: Navigation = Up")
	camera_transition(Nav.LEFT)
	
func _on_btn_down_pressed() -> void:
	print("Museum: Navigation = Down")
	camera_transition(Nav.RIGHT)

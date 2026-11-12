#!navigation.gd
extends Node


enum Nav { LEFT, RIGHT, UP, DOWN }
enum State_Rack    { DATA_BASES, MAP, BARS, PIE, TENDENCY,
					 ARTIFACT_PREVIEW, ARTIFACT,  
					 STORY_0, 
					 STORY_1, STORY_2, STORY_3, 
					 STORY_4, STORY_5, STORY_6, 
					 STORY_7, STORY_8, STORY_9 }

var cam_index = 0 as int
var cam_target: Transform3D
var cam_move = false as bool
var cam_snap_time: float = 0.33
var cam_elapsed: float = 0.0
var cam_start: Transform3D

var state_rack:     State_Rack     = State_Rack.DATA_BASES

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

@onready var pos_story_0        = $"../../World/CameraRig/PosRackA/PosRackA"         as Node3D
@onready var pos_story_1        = $"../../World/CameraRig/PosRackA/PosHistory1"      as Node3D
@onready var pos_story_2        = $"../../World/CameraRig/PosRackA/PosHistory2"      as Node3D
@onready var pos_story_3        = $"../../World/CameraRig/PosRackA/PosHistory3"      as Node3D
@onready var pos_story_4        = $"../../World/CameraRig/PosRackA/PosHistory4"      as Node3D
@onready var pos_story_5        = $"../../World/CameraRig/PosRackA/PosHistory5"      as Node3D
@onready var pos_story_6        = $"../../World/CameraRig/PosRackA/PosHistory6"      as Node3D
@onready var pos_story_7        = $"../../World/CameraRig/PosRackA/PosHistory7"      as Node3D
@onready var pos_story_8        = $"../../World/CameraRig/PosRackA/PosHistory8"      as Node3D
@onready var pos_story_9        = $"../../World/CameraRig/PosRackA/PosHistory9"      as Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_camera_pos(pos_main_menu)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if cam_move:
		_camera_smooth_transition(delta)


# ==========================================
# ============== STATE MACHINE =============
# ==========================================
func camera_transition(nav: Nav) -> void:
	match state_rack:
		State_Rack.DATA_BASES:
			if nav == Nav.LEFT:
				state_rack = State_Rack.STORY_9
				Persistent.set_scene_label("Historia - 9")
				set_camera_pos(pos_story_9)
				return
			if nav == Nav.RIGHT:
				ui.visible = true
				
				state_rack = State_Rack.MAP
				Persistent.set_scene_label("Mapa")
				set_camera_pos(pos_map)
				return
		State_Rack.MAP:
			if nav == Nav.LEFT:
				ui.visible = false
				
				state_rack = State_Rack.DATA_BASES
				Persistent.set_scene_label("Base de datos")
				set_camera_pos(pos_db)
				return
			if nav == Nav.RIGHT:
				state_rack = State_Rack.BARS
				Persistent.set_scene_label("Barras")
				set_camera_pos(pos_graph_bars)
				return
		State_Rack.BARS:
			if nav == Nav.LEFT:
				state_rack = State_Rack.MAP
				Persistent.set_scene_label("Mapa")
				set_camera_pos(pos_map)
				return
			if nav == Nav.RIGHT:
				state_rack = State_Rack.PIE
				Persistent.set_scene_label("Torta")
				set_camera_pos(pos_graph_pie)
				return
		State_Rack.PIE:
			if nav == Nav.LEFT:
				state_rack = State_Rack.BARS
				Persistent.set_scene_label("Barras")
				set_camera_pos(pos_graph_bars)
				return
			if nav == Nav.RIGHT:
				state_rack = State_Rack.TENDENCY
				Persistent.set_scene_label("Tendencia")
				set_camera_pos(pos_graph_tendency)
				return
		State_Rack.TENDENCY:
			if nav == Nav.LEFT:
				state_rack = State_Rack.PIE
				Persistent.set_scene_label("Dona")
				set_camera_pos(pos_graph_pie)
				return
			if nav == Nav.RIGHT:
				ui.visible = false
				
				state_rack = State_Rack.ARTIFACT
				Persistent.set_scene_label("Artefacto")
				set_camera_pos(pos_artifact)
				return
		State_Rack.ARTIFACT:
			if nav == Nav.LEFT:
				ui.visible = true
				
				state_rack = State_Rack.TENDENCY
				Persistent.set_scene_label("Tendencia")
				set_camera_pos(pos_graph_tendency)
				return
			if nav == Nav.RIGHT:
				museum.visible = false
				ui.visible = false
				sumer.show(true)
				
				state_rack = State_Rack.ARTIFACT_PREVIEW
				Persistent.set_scene_label("Artefacto - Funcionamiento")
				Persistent.tablet.visible = true
				set_camera_pos(pos_artifact_prev)
				return
		State_Rack.ARTIFACT_PREVIEW:
			museum.visible = true
			ui.visible = true
			sumer.show(false)
				
			if nav == Nav.LEFT:
				ui.visible = false
				Persistent.tablet.visible = false
				
				state_rack = State_Rack.ARTIFACT
				Persistent.set_scene_label("Artefacto")
				set_camera_pos(pos_artifact)
				return
			if nav == Nav.RIGHT:
				ui.visible = false
				Persistent.tablet.visible = false
				
				state_rack = State_Rack.STORY_0
				Persistent.set_scene_label("Historia")
				set_camera_pos(pos_story_0)
				return
		State_Rack.STORY_0:
			if nav == Nav.LEFT:
				museum.visible = false
				ui.visible = false
				sumer.show(true)
				
				state_rack = State_Rack.ARTIFACT_PREVIEW
				Persistent.set_scene_label("Artefacto - Funcionamiento")
				set_camera_pos(pos_artifact_prev)
				return
			if nav == Nav.RIGHT:
				state_rack = State_Rack.STORY_1
				Persistent.set_scene_label("Historia - 1")
				set_camera_pos(pos_story_1)
				return
		State_Rack.STORY_1:
			if nav == Nav.LEFT:
				state_rack = State_Rack.STORY_0
				Persistent.set_scene_label("Historia")
				set_camera_pos(pos_story_0)
				return
			if nav == Nav.RIGHT:
				state_rack = State_Rack.STORY_2
				Persistent.set_scene_label("Historia - 2")
				set_camera_pos(pos_story_2)
				return
		State_Rack.STORY_2:
			if nav == Nav.LEFT:
				state_rack = State_Rack.STORY_1
				Persistent.set_scene_label("Historia - 1")
				set_camera_pos(pos_story_1)
				return
			if nav == Nav.RIGHT:
				state_rack = State_Rack.STORY_3
				Persistent.set_scene_label("Historia - 3")
				set_camera_pos(pos_story_3)
				return
		State_Rack.STORY_3:
			if nav == Nav.LEFT:
				state_rack = State_Rack.STORY_2
				Persistent.set_scene_label("Historia - 2")
				set_camera_pos(pos_story_2)
				return
			if nav == Nav.RIGHT:
				state_rack = State_Rack.STORY_4
				Persistent.set_scene_label("Historia - 4")
				set_camera_pos(pos_story_4)
				return
		State_Rack.STORY_4:
			if nav == Nav.LEFT:
				state_rack = State_Rack.STORY_3
				Persistent.set_scene_label("Historia - 3")
				set_camera_pos(pos_story_3)
				return
			if nav == Nav.RIGHT:
				state_rack = State_Rack.STORY_5
				Persistent.set_scene_label("Historia - 5")
				set_camera_pos(pos_story_5)
				return
		State_Rack.STORY_5:
			if nav == Nav.LEFT:
				state_rack = State_Rack.STORY_4
				Persistent.set_scene_label("Historia - 4")
				set_camera_pos(pos_story_4)
				return
			if nav == Nav.RIGHT:
				state_rack = State_Rack.STORY_6
				Persistent.set_scene_label("Historia - 6")
				set_camera_pos(pos_story_6)
				return
		State_Rack.STORY_6:
			if nav == Nav.LEFT:
				state_rack = State_Rack.STORY_5
				Persistent.set_scene_label("Historia - 5")
				set_camera_pos(pos_story_5)
				return
			if nav == Nav.RIGHT:
				state_rack = State_Rack.STORY_7
				Persistent.set_scene_label("Historia - 7")
				set_camera_pos(pos_story_7)
				return
		State_Rack.STORY_7:
			if nav == Nav.LEFT:
				state_rack = State_Rack.STORY_6
				Persistent.set_scene_label("Historia - 6")
				set_camera_pos(pos_story_6)
				return
			if nav == Nav.RIGHT:
				state_rack = State_Rack.STORY_8
				Persistent.set_scene_label("Historia - 8")
				set_camera_pos(pos_story_8)
				return
		State_Rack.STORY_8:
			if nav == Nav.LEFT:
				state_rack = State_Rack.STORY_7
				Persistent.set_scene_label("Historia - 7")
				set_camera_pos(pos_story_7)
				return
			if nav == Nav.RIGHT:
				state_rack = State_Rack.STORY_9
				Persistent.set_scene_label("Historia - 9")
				set_camera_pos(pos_story_9)
				return
		State_Rack.STORY_9:
			if nav == Nav.LEFT:
				state_rack = State_Rack.STORY_8
				Persistent.set_scene_label("Historia - 8")
				set_camera_pos(pos_story_8)
				return
			if nav == Nav.RIGHT:
				state_rack = State_Rack.DATA_BASES
				Persistent.set_scene_label("Base de datos")
				set_camera_pos(pos_db)
				return


func set_camera_pos(new_target: Node3D) -> void:
	#camera.global_transform = new_pos.global_transform
	
	cam_start = camera.global_transform
	cam_target = new_target.global_transform
	cam_elapsed = 0.0
	cam_move = true
	

func _camera_smooth_transition(delta: float) -> void:
	cam_elapsed += delta

	var weight = clampf(cam_elapsed / cam_snap_time, 0.0, 1.0)

	# Position
	camera.global_position = cam_start.origin.lerp(
		cam_target.origin,
		weight
	)

	# Rotation
	var start_rotation = cam_start.basis.get_rotation_quaternion()
	var target_rotation = cam_target.basis.get_rotation_quaternion()

	camera.global_transform.basis = Basis(
		start_rotation.slerp(target_rotation, weight)
	)

	# Finish
	if weight >= 1.0:
		camera.global_transform = cam_target
		cam_move = false

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
	
func _on_btn_up_pressed() -> void:
	print("Museum: Navigation = Up")
	camera_transition(Nav.LEFT)
	
func _on_btn_down_pressed() -> void:
	print("Museum: Navigation = Down")
	camera_transition(Nav.RIGHT)

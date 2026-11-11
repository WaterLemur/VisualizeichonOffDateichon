#!artifact_arrows.gd
class_name ArtifactArrows
extends Node


@export_group("References")
@export var arrow_left: Node3D
@export var arrow_right: Node3D
@export var max_angle_pi: float = 0.80 #0.75
@export var min_angle_pi: float = 0.01 #0.0

@export var label_cuneiform: Label
@export var label_arabic:    Label

var counter: int = 0
var rot_angle: float

@export_group("Collision")
@export var pos_col_left:  Node3D
@export var pos_col_right: Node3D
@export var collision_left: Node3D
@export var collision_right: Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision_left.scale.z  = 0
	collision_right.scale.z = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_left(normalized: float) -> void:
	rot_angle = lerp(0.0, max_angle_pi, normalized)
	arrow_left.rotation.y = rot_angle
	collision_left.scale.z = normalized
	
func set_right(normalized: float) -> void:
	rot_angle = lerp(0.0, max_angle_pi, normalized)
	arrow_right.rotation.y = -rot_angle
	collision_right.scale.z = normalized


func _on_area_3d_area_entered(area: Area3D) -> void:
	var soldier := area.get_parent() as Soldier
	if soldier:
		if arrow_left.rotation.y == 0 && arrow_right.rotation.y == 0: return
		
		soldier.plus_1.visible = true
		counter += 1
		label_cuneiform.text = str(counter)

func _on_area_3d_area_exited(area: Area3D) -> void:
	var soldier := area.get_parent() as Soldier
	if soldier:
		soldier.plus_1.visible = false
		counter -= 1
		label_cuneiform.text = str(counter)

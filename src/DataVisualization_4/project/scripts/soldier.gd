#!soldier.gd
class_name Soldier
extends Node


@export_category("References")
@export var plus_1: Label3D
@export var index: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	plus_1.look_at(Vector3(-41.99, 22.211, -106.104), Vector3.UP)
	plus_1.rotate_y(deg_to_rad(180))
	plus_1.visible = false


func _on_area_3d_area_entered(area: Area3D) -> void:
	var artifact := area.get_parent().get_parent() as SumerArrows
	if not artifact: return
	
	plus_1.visible = true
	artifact.is_counted[index] = true

func _on_area_3d_area_exited(area: Area3D) -> void:
	var artifact := area.get_parent().get_parent() as SumerArrows
	if not artifact: return
	
	plus_1.visible = false
	artifact.is_counted[index] = false

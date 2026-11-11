#!soldier.gd
class_name Soldier
extends Node


@export_category("References")
@export var plus_1: Label3D

var counted: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	plus_1.look_at(Vector3(-41.99, 22.211, -106.104), Vector3.UP)
	plus_1.rotate_y(deg_to_rad(180))
	plus_1.visible = false

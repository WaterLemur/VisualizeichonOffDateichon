#!state_navigation.gd
class_name StateNav
extends Node


# Called when the node enters the scene tree for the first time.
func enter(cam: Node3D, pos: Vector3) -> void:
	cam.position = pos

func update() -> void:
	pass
	
func exit() -> void:
	pass

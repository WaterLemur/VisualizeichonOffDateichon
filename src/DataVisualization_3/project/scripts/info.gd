#!info.gd
extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Persistent.set_scene_label("Main Menu")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

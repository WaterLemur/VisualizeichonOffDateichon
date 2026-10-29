#!persistent.gd
extends Node


@onready var label_scene = $UI/Scene as Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("persistent+1")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_scene_label(scene_name: String) -> void:
	if label_scene:
		label_scene.text = scene_name
	else:
		print("no label scene: ")

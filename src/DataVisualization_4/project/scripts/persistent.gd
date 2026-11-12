#!persistent.gd
extends Node


@onready var label_scene = $UI/Scene as Label

@export_category("References")
@export var label_cuneiform: Label
@export var label_arabic:    Label

@export var tablet: TextureRect

@export_category("Tutorials")
@export var tutorial_menu:       Control
@export var tutorial_artifact:   Control
@export var tutorial_navigation: Control
var first_time_tuto_artifact: bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Persistent")
	tutorial_menu.visible       = false
	tutorial_artifact.visible   = false
	tutorial_navigation.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_scene_label(scene_name: String) -> void:
	if label_scene:
		label_scene.text = scene_name
	else:
		print("no label scene: ")


func _on_btn_tuto_menu_pressed() -> void:
	tutorial_menu.visible = false
	Museum.ui.visible = true


func _on_btn_tuto_artifact_pressed() -> void:
	tutorial_artifact.visible = false
	Museum.ui.visible = true
	Museum.nav_obj.visible = true

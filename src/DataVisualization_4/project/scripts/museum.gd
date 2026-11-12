#!museum.gd
extends Node


@onready var ui   = $UI           as Control
@onready var menu = $Scripts/Menu as Node
@onready var nav  = $Scripts/Navigation
@export var nav_obj: Control

var main_menu: String = "res://project/scenes/main_menu.tscn"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Persistent.set_scene_label("Museum")
	ui.visible = false
	ManagerScene.scene_load(main_menu)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

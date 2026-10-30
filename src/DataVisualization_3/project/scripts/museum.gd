#!museum.gd
extends Node


var main_menu: String = "res://project/scenes/main_menu.tscn"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Persistent.set_scene_label("Museum")
	set_navigation(false)
	ManagerScene.scene_load(main_menu)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_navigation(state : bool) -> void:
	$UI.visible = state

#!main_menu.gd
extends Node


var main_menu: String = "res://project/scenes/main_menu.tscn"

var options:   String = "res://project/scenes/options.tscn"
var info:      String = "res://project/scenes/info.tscn"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Persistent.set_scene_label("Main Menu")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_museum_pressed() -> void:
	print("MainMenu: Button = Museum")
	Persistent.set_scene_label("Museum")
	Museum.nav.set_camera_pos(Museum.nav.pos_museum)
	ManagerScene.scene_unload(main_menu)
	
	Persistent.tutorial_menu.visible = true

func _on_button_options_pressed() -> void:
	print("MainMenu: Button = Options")
	ManagerScene.scene_load(options)
	ManagerScene.scene_unload(main_menu)

func _on_button_info_pressed() -> void:
	print("MainMenu: Button = Info")
	ManagerScene.scene_load(info)
	ManagerScene.scene_unload(main_menu)

func _on_button_exit_pressed() -> void:
	print("MainMenu: Button = Exit")
	get_tree().quit()
	

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
	
	
# ==========================================
# ============== MENU ======================
# ==========================================
func _on_tb_tutorial_pressed() -> void:
	print("Museum: Menu = Tutorial")

func _on_tb_info_pressed() -> void:
	print("Museum: Menu = Info")
	
# -------------- Cities ----------------------
func _on_tb_akkad_pressed() -> void:
	print("Museum: Menu = Akkad")

func _on_tb_ur_pressed() -> void:
	print("Museum: Menu = Ur")

func _on_tb_uruk_pressed() -> void:
	print("Museum: Menu = Uruk")
	
# -------------- Resources ----------------------
func _on_tb_barley_pressed() -> void:
	print("Museum: Menu = Barley")

func _on_tb_soldiers_pressed() -> void:
	print("Museum: Menu = Soldiers")

# -------------- Timeline -----------------------
func _on_timeline_value_changed(value: float) -> void:
	print("Museum: Menu = Timeline: %.0f" % value) 

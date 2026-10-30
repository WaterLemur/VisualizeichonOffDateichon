#!menu.gd
extends Node


var tutorial: bool = false
var info:     bool = false

var akkad:    bool = false
var ur:       bool = false
var uruk:     bool = false

var barley:   bool = false
var soldiers: bool = false

var year:     int = 0
var year_min: int = 0
var year_max: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_tutorial(new_state: bool) -> void:
	tutorial = new_state

func set_info(new_state: bool) -> void:
	info = new_state
	
func set_akkad(new_state: bool) -> void:
	akkad = new_state

func set_ur(new_state: bool) -> void:
	ur = new_state

func set_uruk(new_state: bool) -> void:
	uruk = new_state

func set_barley(new_state: bool) -> void:
	barley = new_state

func set_soldiers(new_state: bool) -> void:
	barley = new_state

func set_year(new_year: int) -> void:
	year = new_year

func set_year_min(new_min_year: int) -> void:
	year_min = new_min_year
	
func set_year_max(new_max_year: int) -> void:
	year_max = new_max_year

# ==========================================
# ============== MENU ======================
# ==========================================
func _on_tb_tutorial_pressed() -> void:
	tutorial = true
	print("Museum: Menu = Tutorial")

func _on_tb_info_pressed() -> void:
	info = true
	print("Museum: Menu = Info")
	
# -------------- Cities ----------------------
func _on_tb_akkad_pressed() -> void:
	akkad = not akkad
	print("Museum: Menu = Akkad")

func _on_tb_ur_pressed() -> void:
	ur = not ur
	print("Museum: Menu = Ur")

func _on_tb_uruk_pressed() -> void:
	uruk = not uruk
	print("Museum: Menu = Uruk")
	
# -------------- Resources ----------------------
func _on_tb_barley_pressed() -> void:
	barley = not barley
	print("Museum: Menu = Barley")

func _on_tb_soldiers_pressed() -> void:
	soldiers = not soldiers
	print("Museum: Menu = Soldiers")

# -------------- Timeline -----------------------
func _on_timeline_value_changed(value: float) -> void:
	year = value as int
	print("Museum: Menu = Timeline: %.0f" % value) 

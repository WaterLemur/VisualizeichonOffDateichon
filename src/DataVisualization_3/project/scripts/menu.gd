#!menu.gd
extends Node


@onready var map = $Map


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


func set_tutorial() -> void:
	tutorial = true

func set_info() -> void:
	info = true
	
func set_akkad() -> void:
	akkad = not akkad
	map.set_akkad(akkad)

func set_ur() -> void:
	ur = not akkad
	map.set_ur(ur)

func set_uruk() -> void:
	uruk = not uruk
	map.set_uruk(uruk)

func set_barley() -> void:
	barley = not barley
	map.set_barley(barley)

func set_soldiers() -> void:
	soldiers = not soldiers
	map.set_soldiers(soldiers)

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
	set_tutorial()
	print("Museum: Menu = Tutorial > ", tutorial)

func _on_tb_info_pressed() -> void:
	set_info()
	print("Museum: Menu = Info > ", info)
	
# -------------- Cities ----------------------
func _on_tb_akkad_pressed() -> void:
	set_akkad()
	
	print("Museum: Menu = Akkad > ", akkad)

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
	set_year(value as int)
	print("Museum: Menu = Timeline: %.0f" % value) 

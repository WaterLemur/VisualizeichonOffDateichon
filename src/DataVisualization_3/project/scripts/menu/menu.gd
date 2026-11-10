#!menu.gd
extends Node


@onready var timeline = $Timeline
@onready var map      = $Map


var tutorial: bool = false
var info:     bool = false

var akkad:    bool = true
var ur:       bool = true
var uruk:     bool = true

var barley:   bool = true
var soldiers: bool = true

var year_min: int = 2400
var year_max: int = 2600

@onready var bar_1      = $"../../World/Sprites/Graphs/Bar1/SVBar1/GraphBar1"
@onready var bar_2      = $"../../World/Sprites/Graphs/Bar2/SVBar2/GraphBar2"
@onready var pie        = $"../../World/Sprites/Graphs/Pie/SVPie/GraphPie"
@onready var tendency   = $"../../World/Sprites/Graphs/Tendency/SVTendency/GraphTendency"

@onready var tb_akkad    = $"../../UI/Menu/TBAkkad"    as TextureButton
@onready var tb_ur       = $"../../UI/Menu/TBUr"       as TextureButton
@onready var tb_uruk     = $"../../UI/Menu/TBUruk"     as TextureButton
@onready var tb_barley   = $"../../UI/Menu/TBBarley"   as TextureButton
@onready var tb_soldiers = $"../../UI/Menu/TBSoldiers" as TextureButton

@onready var button_green: Texture2D = load("res://project/art/sprites/menu/button_green.png")
@onready var button_red:   Texture2D = load("res://project/art/sprites/menu/button_red.png")
@onready var button_blue:  Texture2D = load("res://project/art/sprites/menu/button_blue.png")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timeline.set_year_min(year_min)
	timeline.set_year_max(year_max)

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
	
	bar_1.show_akkad = akkad
	bar_1.update_chart()
	bar_2.show_akkad = akkad
	bar_2.update_chart()
	pie.show_akkad = akkad
	pie.update_chart()
	tendency.show_akkad = akkad
	tendency.update_chart()
	

func set_ur() -> void:
	ur = not ur
	
	map.set_ur(ur)
	
	bar_1.show_ur = ur
	bar_1.update_chart()
	bar_2.show_ur = ur
	bar_2.update_chart()
	pie.show_ur = ur
	pie.update_chart()
	tendency.show_ur = ur
	tendency.update_chart()

func set_uruk() -> void:
	uruk = not uruk
	
	map.set_uruk(uruk)
	
	bar_1.show_uruk = uruk
	bar_1.update_chart()
	bar_2.show_uruk = uruk
	bar_2.update_chart()
	pie.show_uruk = uruk
	pie.update_chart()
	tendency.show_uruk = uruk
	tendency.update_chart()
	
func set_barley() -> void:
	barley = not barley
	
	#map.set_barley(barley)
	
	bar_1.show_barley = barley
	bar_1.update_chart()
	#bar_2.show_barley = barley
	#bar_2.update_chart()
	pie.show_barley = barley
	pie.update_chart()
	tendency.show_barley = barley
	tendency.update_chart()

func set_soldiers() -> void:
	soldiers = not soldiers
	
	#map.set_soldiers(soldiers)
	
	bar_1.show_soldiers = soldiers
	bar_1.update_chart()
	#bar_2.show_soldiers = soldiers
	#bar_2.update_chart()
	pie.show_soldiers = soldiers
	pie.update_chart()
	tendency.show_soldiers = soldiers
	tendency.update_chart()

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
	_set_btn_texture(tb_akkad, akkad)
	print("Museum: Menu = Akkad > ", akkad)

func _on_tb_ur_pressed() -> void:
	set_ur()
	_set_btn_texture(tb_ur, ur)
	print("Museum: Menu = Ur > ", ur)

func _on_tb_uruk_pressed() -> void:
	set_uruk()
	_set_btn_texture(tb_uruk, uruk)
	print("Museum: Menu = Uruk > ", uruk)
	
# -------------- Resources ----------------------
func _on_tb_barley_pressed() -> void:
	set_barley()
	_set_btn_texture(tb_barley, barley)
	print("Museum: Menu = Barley")

func _on_tb_soldiers_pressed() -> void:
	set_soldiers()
	_set_btn_texture(tb_soldiers, soldiers)
	print("Museum: Menu = Soldiers")

func _set_btn_texture(tx_btn: TextureButton, state: int) -> void:
	match state:
		-1:
			tx_btn.texture_normal = button_blue
			tx_btn.texture_hover  = button_blue
		0:
			tx_btn.texture_normal = button_red
			tx_btn.texture_hover = button_red
		1:
			tx_btn.texture_normal = button_green
			tx_btn.texture_hover = button_green
# -------------- Timeline -----------------------
func _on_range_slider_v_range_changed(min_value: float, max_value: float) -> void:
	year_min = min_value
	timeline.set_year_min(year_min)
	tendency.update_chart()
	print("Museum: Menu = Timeline Min: %.0f" % min_value)
	
	year_max = max_value
	timeline.set_year_max(year_max)
	tendency.update_chart()
	print("Museum: Menu = Timeline Max: %.0f" % max_value) 

# -------------- Hover -----------------------
func _on_tb_akkad_mouse_entered() -> void:
	# set_akkad
	#map.set_akkad(akkad)
	
	#bar_1.show_akkad = akkad
	#bar_1.update_chart()
	#bar_2.show_akkad = akkad
	#bar_2.update_chart()
	#pie.show_akkad = akkad
	#pie.update_chart()
	#tendency.show_akkad = akkad
	#tendency.update_chart()
	 
	_set_btn_texture(tb_akkad, -1)

func _on_tb_akkad_mouse_exited() -> void:
	_set_btn_texture(tb_akkad, akkad)

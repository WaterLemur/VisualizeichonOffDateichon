#!map.gd
extends Node


@onready var akkad = $"../../../World/Sprites/Map/MapAkkad"
@onready var ur    = $"../../../World/Sprites/Map/MapUr"
@onready var uruk  = $"../../../World/Sprites/Map/MapUruk"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_akkad(state: bool) -> void:
	akkad.visible = state

func set_ur(state: bool) -> void:
	ur.visible = state

func set_uruk(state: bool) -> void:
	uruk.visible = state

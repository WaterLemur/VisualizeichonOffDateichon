class_name Sumer
extends Node


@onready var ui    = $UI as Control
@onready var world = $World as Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func show(state: bool) -> void:
	print("UI: ", ui)
	print("World: ", world)

	ui.visible = state
	world.visible = state

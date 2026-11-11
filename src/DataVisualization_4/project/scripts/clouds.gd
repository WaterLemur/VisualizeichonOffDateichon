#!clouds.gd
extends Node3D


@export_category("Variables")
@export var speed: float = 20.0
@export var distance:float = 200.0

var start_pos: Vector3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_pos = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x += speed * delta
	
	var d = start_pos.distance_to(position)
	if d > distance:
		position = start_pos

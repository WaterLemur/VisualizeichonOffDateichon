#!menu_artifact.gd
extends Control


@export_group("References")
@export var window_left: Control
@export var window_right: Control

@export_group("Left Range")
@export var left_min: float = 338.5
@export var left_max: float = 446.5
@export var left_start: float = left_max

@export_group("Right Range")
@export var right_min: float = 557.0
@export var right_max: float = 660.0
@export var right_start: float = right_min

@export_group("3D Arrows")
@export var arrow_script: SumerArrows

var dragging: Control = null


func _ready() -> void:
	window_left.gui_input.connect(_on_handle_input.bind(window_left))
	window_right.gui_input.connect(_on_handle_input.bind(window_right))

	window_left.position.x = left_start
	window_right.position.x = right_start


func _on_handle_input(event: InputEvent, handle: Control) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			dragging = handle
			handle.accept_event()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			dragging = null

	if event is InputEventMouseMotion and dragging != null:
		var mouse_x = get_local_mouse_position().x
		var normalized: float

		if dragging == window_left:
			dragging.position.x = clampf(mouse_x - dragging.size.x * 0.5, left_min, left_max)
			normalized = inverse_lerp(left_max, left_min, dragging.position.x)
			
			arrow_script.set_left(normalized)

		elif dragging == window_right:
			dragging.position.x = clampf(mouse_x - dragging.size.x * 0.5, right_min, right_max)
			normalized = inverse_lerp(right_min, right_max, dragging.position.x)
			
			arrow_script.set_right(normalized)

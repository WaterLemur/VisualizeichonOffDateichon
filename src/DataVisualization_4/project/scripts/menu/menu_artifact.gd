#!menu_artifact.gd
extends Control


@export_group("References")
@export var window_left:  Control
@export var window_right: Control
@export var red_left:     Control
@export var red_right:    Control
@export var r_offset_left: Vector2 = Vector2(-0.01,-0.05)
@export var r_offset_right: Vector2 = Vector2(-0.01,-0.05)

@export_group("Left Range")
@export var left_min:   float = 540.8
@export var left_max:   float = 736.0
@export var left_start: float = left_max

@export_group("Right Range")
@export var right_min:   float = 991.0
@export var right_max:   float = 1200.0
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
			print(window_left.position.x)
			dragging.position.x = clampf(mouse_x - dragging.size.x * 0.5, left_min, left_max)
			normalized = inverse_lerp(left_max, left_min, dragging.position.x)
			
			arrow_script.set_left(normalized)
			red_left.position = window_left.position + r_offset_left

		elif dragging == window_right:
			dragging.position.x = clampf(mouse_x - dragging.size.x * 0.5, right_min, right_max)
			normalized = inverse_lerp(right_min, right_max, dragging.position.x)
			
			arrow_script.set_right(normalized)
			red_right.position = window_right.position + r_offset_left

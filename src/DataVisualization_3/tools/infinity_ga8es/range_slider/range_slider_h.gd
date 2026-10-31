extends Control
class_name RSliderH

signal range_changed(min_value: float, max_value: float)

@export var min_limit: float = 0.0
@export var max_limit: float = 100.0

@export var min_value: float = 20.0
@export var max_value: float = 80.0

@export var step: float = 1.0

const HANDLE_RADIUS := 9.0
const TRACK_HEIGHT := 5.0

var dragging := -1 # 0 = min handle, 1 = max handle


func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	queue_redraw()


func _draw() -> void:
	var center_y := size.y / 2.0
	var left := HANDLE_RADIUS
	var right := size.x - HANDLE_RADIUS

	var min_x := value_to_position(min_value)
	var max_x := value_to_position(max_value)

	# Background track
	draw_rect(
		Rect2(left, center_y - TRACK_HEIGHT / 2.0, right - left, TRACK_HEIGHT),
		Color.GRAY
	)

	# Selected range
	draw_rect(
		Rect2(min_x, center_y - TRACK_HEIGHT / 2.0, max_x - min_x, TRACK_HEIGHT),
		Color("#36a2eb")
	)

	# Handles
	draw_circle(Vector2(min_x, center_y), HANDLE_RADIUS, Color.WHITE)
	draw_circle(Vector2(max_x, center_y), HANDLE_RADIUS, Color.WHITE)


func value_to_position(value: float) -> float:
	var width := size.x - HANDLE_RADIUS * 2.0
	return HANDLE_RADIUS + (value - min_limit) / (max_limit - min_limit) * width


func position_to_value(position: float) -> float:
	var width := size.x - HANDLE_RADIUS * 2.0
	var value := min_limit + (position - HANDLE_RADIUS) / width * (max_limit - min_limit)
	return snapped(value, step)


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				var min_x := value_to_position(min_value)
				var max_x := value_to_position(max_value)

				dragging = 0 if abs(event.position.x - min_x) < abs(event.position.x - max_x) else 1
				_update_value(event.position.x)
			else:
				dragging = -1

	if event is InputEventMouseMotion and dragging != -1:
		_update_value(event.position.x)


func _update_value(mouse_x: float) -> void:
	var value: float = clampf(position_to_value(mouse_x), min_limit, max_limit)
	if dragging == 0:
		min_value = min(value, max_value)
	else:
		max_value = max(value, min_value)

	queue_redraw()
	range_changed.emit(min_value, max_value)


func _on_range_changed(min_value: float, max_value: float) -> void:
	print("Minimum: ", min_value)
	print("Maximum: ", max_value)

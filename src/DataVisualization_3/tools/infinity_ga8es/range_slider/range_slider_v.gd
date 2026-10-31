extends Control
class_name RSliderV

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
	custom_minimum_size = Vector2(30, 200)
	queue_redraw()


func _draw() -> void:
	var center_x := size.x / 2.0
	var top := HANDLE_RADIUS
	var bottom := size.y - HANDLE_RADIUS

	var min_y := value_to_position(min_value)
	var max_y := value_to_position(max_value)

	# Background track
	draw_rect(
		Rect2(center_x - TRACK_HEIGHT / 2.0, top, TRACK_HEIGHT, bottom - top),
		Color(0.776, 0.259, 0.29, 1.0)
	)

	# Selected range
	draw_rect(
		Rect2(
			center_x - TRACK_HEIGHT / 2.0,
			max_y,
			TRACK_HEIGHT,
			min_y - max_y
		),
		Color("39895cff")
	)

	# Handles
	draw_circle(Vector2(center_x, min_y), HANDLE_RADIUS, Color(0.788, 0.651, 0.235, 1.0))
	draw_circle(Vector2(center_x, max_y), HANDLE_RADIUS, Color(0.788, 0.651, 0.235, 1.0))


func value_to_position(value: float) -> float:
	var height := size.y - HANDLE_RADIUS * 2.0
	return size.y - HANDLE_RADIUS - (value - min_limit) / (max_limit - min_limit) * height


func position_to_value(position: float) -> float:
	var height := size.y - HANDLE_RADIUS * 2.0
	var value := min_limit + ((size.y - HANDLE_RADIUS - position) / height) * (max_limit - min_limit)
	return snapped(value, step)


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				var min_y := value_to_position(min_value)
				var max_y := value_to_position(max_value)

				dragging = 0 if abs(event.position.y - min_y) < abs(event.position.y - max_y) else 1
				_update_value(event.position.y)
			else:
				dragging = -1

	if event is InputEventMouseMotion and dragging != -1:
		_update_value(event.position.y)


func _update_value(mouse_y: float) -> void:
	var value: float = clampf(position_to_value(mouse_y), min_limit, max_limit)

	if dragging == 0:
		min_value = min(value, max_value)
	else:
		max_value = max(value, min_value)

	queue_redraw()
	range_changed.emit(min_value, max_value)


func _on_range_changed(minimum: float, maximum: float) -> void:
	print("Minimum: ", minimum)
	print("Maximum: ", maximum)

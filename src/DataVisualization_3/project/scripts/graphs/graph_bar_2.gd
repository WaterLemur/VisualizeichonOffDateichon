#!graph_bar_2.gd
extends Control


var show_akkad := true
var show_ur := true
var show_uruk := true

var show_barley := true
var show_soldiers := true

var chart: Chart


func _ready() -> void:
	var chart_scene: PackedScene = load(
		"res://addons/easy_charts/control_charts/chart.tscn"
	)

	chart = chart_scene.instantiate()
	add_child(chart)

	update_chart()


func update_chart() -> void:
	var properties := ChartProperties.new()

	properties.title = "Mesopotamian Conquest Resources"
	properties.show_legend = true
	properties.x_label = "City-States"
	properties.y_label = "Resource Volumes"
	properties.interactive = true
	properties.colors.text = Color("#D9A441")

	var x: Array = []
	var barley: Array = []
	var soldiers: Array = []

	var cities = [
		["Akkad", 40000.0, 15000.0, show_akkad],
		["Ur", 22000.0, 7000.0, show_ur],
		["Uruk", 25000.0, 12000.0, show_uruk]
	]

	for city in cities:
		if city[3]:
			x.append(city[0])
			barley.append(city[1])
			soldiers.append(city[2])

	var functions: Array[Function] = []

	const BAR_SIZE := 5.0

	# Offset bars only when both resources are enabled.
	var both_visible := show_barley and show_soldiers

	if show_barley and not x.is_empty():
		functions.append(Function.new(
			x,
			barley,
			"Cebada (Gur)",
			{
				type = Function.Type.BAR,
				bar_size = BAR_SIZE,
				bar_offset = -BAR_SIZE if both_visible else 0.0,
				color = Color("ebc860ff")
			}
		))

	if show_soldiers and not x.is_empty():
		functions.append(Function.new(
			x,
			soldiers,
			"Soldados",
			{
				type = Function.Type.BAR,
				bar_size = BAR_SIZE,
				bar_offset = BAR_SIZE if both_visible else 0.0,
				color = Color("604914ff")
			}
		))

	if functions.is_empty():
		return

	chart.plot(functions, properties)
	chart.queue_redraw()


# CITY FILTERS

func _on_akkad_button_toggled(value: bool) -> void:
	show_akkad = value
	update_chart()


func _on_ur_button_toggled(value: bool) -> void:
	show_ur = value
	update_chart()


func _on_uruk_button_toggled(value: bool) -> void:
	show_uruk = value
	update_chart()


# RESOURCE FILTERS

func _on_barley_button_toggled(value: bool) -> void:
	show_barley = value
	update_chart()


func _on_soldiers_button_toggled(value: bool) -> void:
	show_soldiers = value
	update_chart()

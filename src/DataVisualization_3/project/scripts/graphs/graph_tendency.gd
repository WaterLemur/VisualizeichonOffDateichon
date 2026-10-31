#!graph_tendency.gd
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

	properties.title = "Recursos a travéz del tiempo"
	properties.show_legend = true
	properties.x_label = "Año"
	properties.y_label = "Cantidad"
	properties.interactive = true
	properties.colors.text = Color("#D9A441")

	var x: Array = [0.0, 1.0, 2.0]
	var barley: Array = []
	var soldiers: Array = []

	var cities = [
		["Akkad", 40000.0, 15000.0, show_akkad, 0.0],
		["Ur", 22000.0, 7000.0, show_ur, 1.0],
		["Uruk", 25000.0, 12000.0, show_uruk, 2.0]
	]
	
	for city in cities:
		if city[3]:
			x.append(city[4])
			barley.append(city[1])
			soldiers.append(city[2])

	var functions: Array[Function] = []

	# Barley
	if show_barley and not x.is_empty():
		functions.append(Function.new(
			x,
			barley,
			"Cebada (Gur)",
			{
				type = Function.Type.LINE,
				marker = Function.Marker.SQUARE,
				color = Color("f7d37eff")
			}
		))

	# Soldiers
	if show_soldiers and not x.is_empty():
		functions.append(Function.new(
			x,
			soldiers,
			"Soldados",
			{
				type = Function.Type.LINE,
				marker = Function.Marker.SQUARE,
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

#!graph_bar_1.gd
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

	# ----- THEMING -----------

	update_chart()


func update_chart() -> void:
	var properties := ChartProperties.new()

	properties.title = "Barras 1"
	properties.show_legend = true
	properties.x_label = "City-States"
	properties.y_label = "Resource Volumes"

	properties.interactive = true

	var x: Array = []
	var barley: Array = []
	var soldiers: Array = []

	# City data
	var cities = [
		["Akkad", 40000.0, 15000.0, show_akkad],
		["Uruk", 25000.0, 12000.0, show_uruk],
		["Ur", 22000.0, 7000.0, show_ur]
	]

	# Collect selected cities
	for city in cities:
		if city[3]:
			x.append(city[0])
			barley.append(city[1])
			soldiers.append(city[2])

	var functions: Array[Function] = []

	# Barley
	if show_barley and not x.is_empty():
		functions.append(Function.new(
			x,
			barley,
			"Barley (Gur)",
			{
				type = Function.Type.BAR,
				bar_size = 5,
				color = Color("ebc860ff")
			}
		))

	# Soldiers
	if show_soldiers and not x.is_empty():
		functions.append(Function.new(
			x,
			soldiers,
			"Soldiers",
			{
				type = Function.Type.BAR,
				bar_size = 5,
				color = Color("604914ff")
			}
		))

	if functions.is_empty():
		return

	chart.plot(functions, properties)
	chart.queue_redraw()

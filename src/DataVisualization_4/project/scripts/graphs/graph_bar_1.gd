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
        "res://addons/easy_charts/control_charts/chart_left.tscn"
	)

	chart = chart_scene.instantiate()
	add_child(chart)

	# ----- THEMING -----------

	update_chart()


func update_chart() -> void:
	var properties := ChartProperties.new()

	properties.title = ""
	properties.show_legend = false
	properties.x_label = ""
	#properties.y_label = "Cantidad\nrecursos"
	properties.colors.text = Color("#D9A441")

	properties.interactive = true

	var x: Array = []
	var barley: Array = []
	var soldiers: Array = []

	# City data
	var cities = [
		["Akkad", 40000.0, 10000.0, show_akkad],
		["Uruk",  45000.0, 15000.0, show_uruk],
		["Ur",    50000.0, 20000.0, show_ur]
	]

	for city in cities:
		if city[3]:
			var total: float = city[1] + city[2]

			x.append(city[0])
			barley.append(city[1] / total * 100.0)
			soldiers.append(city[2] / total * 100.0)
			

	var functions: Array[Function] = []

	# Barley
	if show_barley and not x.is_empty():
		functions.append(Function.new(
			x,
			barley,
			"Cebada (gur)",
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
			"Soldados",
			{
				type = Function.Type.BAR,
				bar_size = 5,
				color = Color("604914ff")
			}
		))

	chart.plot(functions, properties)
	chart.queue_redraw()

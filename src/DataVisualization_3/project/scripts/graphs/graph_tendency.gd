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
	properties.x_label = ""
	properties.y_label = ""
	properties.interactive = true
	properties.colors.text = Color("#D9A441")

	var functions: Array[Function] = []

	var cities = [
		["Akkad", show_akkad],
		["Ur", show_ur],
		["Uruk", show_uruk]
	]

	var resources = [
		[2, show_barley, "Cebada (gur)", Color("f7d37eff")],
		[3, show_soldiers, "Soldados", Color("604914ff")]
	]

	for city in cities:
		if not city[1]:
			continue

		for resource in resources:
			if not resource[1]:
				continue

			var x: Array = []
			var y: Array = []

			for row in DataBase.DATABASE:
				if row[1] != city[0]:
					continue

				var value = row[resource[0]]

				# Ignore missing database values
				if value == null:
					continue

				x.append(float(row[0]))
				y.append(value)

			if x.is_empty():
				continue

			functions.append(Function.new(
				x,
				y,
				city[0] + " - " + resource[2],
				{
					type = Function.Type.LINE,
					marker = Function.Marker.SQUARE,
					color = resource[3]
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

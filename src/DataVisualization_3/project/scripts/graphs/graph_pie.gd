#!graph_pie.gd
extends Control

# City filters
var show_akkad := true
var show_ur := true
var show_uruk := true

# Resource filters
var show_barley := true
var show_soldiers := true

var chart: Chart

const CITY_DATA = {
	"Akkad": {"Cebada": 55000, "Soldados": 25000},
	"Ur":    {"Cebada": 60000, "Soldados": 30000},
	"Uruk":  {"Cebada": 65000, "Soldados": 35000}
}

func _ready() -> void:
	var chart_scene: PackedScene = load(
        "res://addons/easy_charts/control_charts/chart.tscn"
	)

	chart = chart_scene.instantiate()
	add_child(chart)

	update_chart()


func update_chart() -> void:
	var base_color := Color("886f23ff")

	var gradient := Gradient.new()
	gradient.set_color(0, base_color.darkened(0.33))
	gradient.set_color(1, base_color.lightened(0.33))
	
	
	
	
	var values: Array = []
	var labels: Array = []

	var selected_cities = []

	if show_akkad:
		selected_cities.append("Akkad")
	if show_ur:
		selected_cities.append("Ur")
	if show_uruk:
		selected_cities.append("Uruk")

	for city in selected_cities:
		if show_barley:
			values.append(CITY_DATA[city]["Cebada"])
			labels.append(city + " Cebada")

		if show_soldiers:
			values.append(CITY_DATA[city]["Soldados"])
			labels.append(city + " Soldados")

	var properties := ChartProperties.new()
	properties.title = ""
	properties.show_legend = true
	properties.colors.text = Color("#D9A441")
	properties.draw_vertical_grid = false
	properties.draw_horizontal_grid = false
	properties.show_tick_labels = false

	# Rebuild the chart using the selected data
	var function := Function.new(
		values,
		labels,
		"Resource Records",
		{
			type = Function.Type.PIE,
			marker = Function.Marker.CIRCLE,
			gradient = gradient
		}
	)

	chart.plot([function], properties)

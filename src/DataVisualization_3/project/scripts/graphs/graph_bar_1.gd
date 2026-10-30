#!graph_pie_1.gd
extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var chart_scene: PackedScene = load("res://addons/easy_charts/control_charts/chart.tscn")
	var chart: Chart = chart_scene.instantiate()
	add_child(chart)
	
	var chart_properties := ChartProperties.new()
	chart_properties.title = "Mesopotamian Conquest Resources"
	chart_properties.show_legend = true
	chart_properties.x_label = "City-States"
	chart_properties.y_label = "Resource Volumes"
	
	# The X-Axis contains the cities
	var cities: Array = ["Akkad", "Uruk", "Ur"]
	
	# Grounded Data Metrics: Barley in Gur vs. Active Soldiery Force
	var barley_data: Array = [40000, 25000, 22000]
	var soldier_data: Array = [15000, 12000, 7000]
	
	# 1. Barley Function Configuration (Green/Yellowish Tint)
	var f_barley := Function.new(
		cities,
		barley_data,
		"Barley (Gur)",
		{
			type = Function.Type.BAR,
			marker = Function.Marker.CIRCLE,
			color = Color("#9eb23b") # Historic Olive / Green-Yellowish Hex Color
		}
	)
	
	# 2. Soldiers Function Configuration (Strict Deep Red)
	var f_soldiers := Function.new(
		cities,
		soldier_data,
		"Soldiers",
		{
			type = Function.Type.BAR,
			marker = Function.Marker.CIRCLE,
			color = Color("#b33939") # Dark Crimson Red Hex Color
		}
	)
	
	# Plot both functions simultaneously on the chart array
	chart.plot([f_barley, f_soldiers], chart_properties)

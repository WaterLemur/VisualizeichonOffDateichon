#!graph_bar_1.gd
extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var chart_scene: PackedScene = load("res://addons/easy_charts/control_charts/chart.tscn")
	var chart: Chart = chart_scene.instantiate()
	add_child(chart)
	
	var chart_properties := ChartProperties.new()
	chart_properties.title = "Example Bar Chart"
	chart_properties.show_legend = true
	chart_properties.x_label = "Categories"
	chart_properties.y_label = "Values"
	
	# Explicitly assigning arrays to clean variables ensures perfect signature alignment
	var x_labels: Array = ["Zero", "One", "Two", "Three", "Four", "Five", "Six"]
	var y_values: Array = [4, 8, 2, 9, 7, 8, 12]
	var function_name: String = "First function"
	
	var function := Function.new(
		x_labels,
		y_values,
		function_name,
		{
			type = Function.Type.BAR,
			marker = Function.Marker.CIRCLE,
			color = Color("#36a2eb"),
		}
	)
	chart.plot([function], chart_properties)

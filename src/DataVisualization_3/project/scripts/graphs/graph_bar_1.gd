#!graph_bar_1.gd
extends Control


func _ready() -> void:
	var chart_scene: PackedScene = load("res://addons/easy_charts/control_charts/chart.tscn")
	var chart: Chart = chart_scene.instantiate()
	add_child(chart)
	
	var function := Function.new(
		[0, 1, 2, 3, 4, 5, 6],  # The function's X-values
		[4, 8, 2, 9, 7, 8, 12], # The function's Y-values
		"First function",       # The function's name
		{
			type = Function.Type.LINE,       # The function's type
			marker = Function.Marker.SQUARE, # Some function types have additional configuraiton
			color = Color("#36a2eb"),        # The color of the drawn function
		}
	)

	var chart_properties := ChartProperties.new()
	chart_properties.x_label = "X-Axis"
	chart_properties.y_label = "Y-Axis"
	chart_properties.title = "Example chart"
	chart_properties.show_legend = true

	chart.plot([function], chart_properties)

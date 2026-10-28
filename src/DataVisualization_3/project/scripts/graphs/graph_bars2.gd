#!graph.gd
extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var chart: Chart = $UI/Chart
	
	var chart_properties := ChartProperties.new()
	chart_properties.x_label = "X-Axis"
	chart_properties.y_label = "Y-Axis"
	chart_properties.title = "Example chart"
	chart_properties.show_legend = true
	
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
	chart.plot([function], chart_properties)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

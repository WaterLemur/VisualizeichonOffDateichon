#!graph_pie_1.gd
extends Control


#@onready var chart = $UI/Chart


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#add_child(chart)
	
	var chart_properties := ChartProperties.new()
	chart_properties.title = "Example Pie Chart"
	chart_properties.show_legend = true
	
	var function := Function.new(
		[4, 8, 2, 9, 7, 8, 12],                # 1st Argument: Values/Sizes (Numbers)
		["Zero", "One", "Two", "Three", "Four", "Five", "Six"], # 2nd Argument: Labels (Strings)
		"First function",                      # 3rd Argument: Name of the function
		{
			type = Function.Type.PIE,       
			marker = Function.Marker.CIRCLE, 
			color = Color("#36a2eb"),        
		}
	)
	#chart.plot([function], chart_properties)

#!graph_pie_2.gd
extends Control

func _ready() -> void:
	var chart_scene: PackedScene = load(
        "res://addons/easy_charts/control_charts/chart.tscn"
	)

	var chart: Chart = chart_scene.instantiate()
	add_child(chart)

	var chart_properties := ChartProperties.new()
	chart_properties.title = "Mesopotamian City Records"
	chart_properties.show_legend = true

	# Barley records
	var barley := Function.new(
		[120, 85, 150],
		["Akkad", "Ur", "Uruk"],
		"Barley (measures)",
		{
			type = Function.Type.PIE,
			marker = Function.Marker.CIRCLE,
			color = Color("#A6B83B")
		}
	)

	# Military personnel records
	var soldiers := Function.new(
		[45, 70, 55],
		["Akkad", "Ur", "Uruk"],
		"Soldiers (men)",
		{
			type = Function.Type.PIE,
			marker = Function.Marker.CIRCLE,
			color = Color("#C0392B")
		}
	)

	chart.plot([barley, soldiers], chart_properties)

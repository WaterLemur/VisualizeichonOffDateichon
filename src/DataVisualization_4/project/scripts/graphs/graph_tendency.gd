#!graph_tendency.gd
extends Control


@onready var menu = $"../../../../../../Scripts/Menu"

var show_akkad := true
var show_ur := true
var show_uruk := true

var show_barley := true
var show_soldiers := true

var chart: Chart


@export_group("Chart Colors")

@export var akkad_barley_color: Color = Color("81631eff")
@export var akkad_soldiers_color: Color = Color("604914ff")

@export var ur_barley_color: Color = Color("8a763eff")
@export var ur_soldiers_color: Color = Color("6c5c2eff")

@export var uruk_barley_color: Color = Color("ebc860ff")
@export var uruk_soldiers_color: Color = Color("b19231ff")


func _ready() -> void:
	var chart_scene: PackedScene = load(
		"res://addons/easy_charts/control_charts/chart.tscn"
	)

	chart = chart_scene.instantiate()
	add_child(chart)

	update_chart()


func update_chart() -> void:
	var properties := ChartProperties.new()

	properties.title = ""
	properties.show_legend = true
	properties.x_label = ""
	properties.y_label = ""
	properties.interactive = true
	properties.colors.text = Color("#D9A441")

	var functions: Array[Function] = []

	var cities = [
		["Akkad", show_akkad, akkad_barley_color, akkad_soldiers_color],
		["Ur", show_ur, ur_barley_color, ur_soldiers_color],
		["Uruk", show_uruk, uruk_barley_color, uruk_soldiers_color]
	]

	var resources = [
		[2, show_barley, "Cebada (gur)", 2],
		[3, show_soldiers, "Soldados", 3]
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

				var year: int = int(row[0])

				if year < menu.year_min or year > menu.year_max:
					continue

				var value = row[resource[0]]

				# Ignore missing database values
				if value == null:
					continue

				x.append(float(year))
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
					color = city[resource[3]]
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

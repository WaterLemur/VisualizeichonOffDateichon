#!timeline.gd
extends Node


@onready var year     = $"../../../UI/Menu/Timeline/Year"    as Label
@onready var year_min = $"../../../UI/Menu/Timeline/YearMin" as Label
@onready var year_max = $"../../../UI/Menu/Timeline/YearMax" as Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_year(new_year: int) -> void:
	year.text = new_year

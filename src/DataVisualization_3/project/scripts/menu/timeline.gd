#!timeline.gd
extends Node


@onready var slider   = $"../../../UI/Menu/Timeline/VSlider" as VSlider
@onready var year_min = $"../../../UI/Menu/Timeline/YearMin" as Label
@onready var year_max = $"../../../UI/Menu/Timeline/YearMax" as Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

	
func set_year_min(new_min: int) -> void:
	year_min.text = str(new_min) + " A.C."

func set_year_max(new_max: int) -> void:
	year_max.text = str(new_max) + " A.C."
	

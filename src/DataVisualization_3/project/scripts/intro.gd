#!intro.gd
extends Node


var intro:       String = "res://project/scenes/intro.tscn"
var timer:        float = 0.7
var _timer_print: float = 20
var timer_print:  float = _timer_print


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Persistent.set_scene_label("")
	ManagerScene.scene_unload(intro)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_check_timer(delta)


func _check_timer(delta: float) -> void:
	timer -= delta
	timer_print -= 1
	
	if timer_print <=0:
		print(timer)
		timer_print = _timer_print
	
	if timer <= 0:
		ManagerScene.scene_unload(intro)

#!boot.gd
extends Node


var persistent = load("res://project/scenes/persistent.tscn") as PackedScene
var intro: String = "res://project/scenes/intro.tscn"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Boot")
	add_child(persistent.instantiate())
	ManagerScene.scene_load(intro)

#!manager_audio.gd
extends Node

@onready var music_hymn:      AudioStreamPlayer = $MusicHymn
@onready var music_gilgamesh: AudioStreamPlayer = $MusicGilgamesh


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var random: int = randi_range(0,1)
	random = 1
	if random == 0:
		play_hymn()
	else:
		play_gilgamesh()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func play_hymn() -> void:
	print("MangerAudio: play_hymn")
	music_hymn.play()

func play_gilgamesh() -> void:
	print("MangerAudio: play_gilgamesh")
	music_gilgamesh.play()


func _on_music_hymn_finished() -> void:
	play_gilgamesh()

func _on_music_gilgamesh_finished() -> void:
	play_hymn()

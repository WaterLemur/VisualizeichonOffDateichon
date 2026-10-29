#!manager_scene.gd
extends Node


var open_scenes: Array[Node] = [] #Resource


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func scene_load(path: String) -> void:
	var scene = load(path) as PackedScene
	var instance = scene.instantiate()
	open_scenes.append(instance)
	add_child(instance)
	#print("ManagerScene: load = " + instance)

func scene_unload(path: String) -> void:
	for i in range(open_scenes.size() - 1, -1, -1):
		var live_scene = open_scenes[i]
		
		if is_instance_valid(live_scene) and live_scene.scene_file_path == path:
			#print("ManagerScene: unload = " + live_scene)
			live_scene.queue_free()
			open_scenes.remove_at(i)
			return

extends Node


func change_scene(save_current_scene: bool, current_scene: Node, current_scene_path: String, new_scene_path: String):
	# Add a tansition
	var new_scene: Node
	
	if save_current_scene:
			var saved_scene = PackedScene.new()
			saved_scene.pack(current_scene)
			EnvVar.saved_scenes[current_scene_path] = saved_scene
	
	if new_scene_path in EnvVar.saved_scenes:
		new_scene = EnvVar.saved_scenes[new_scene_path].instance()
	else:
		new_scene = load(new_scene_path).instance()

	add_child(new_scene)
	
	current_scene.queue_free()
	

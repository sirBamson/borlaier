extends Node

var last_scene 


func change_to_scene(current_scene: Node, save_current_scene: bool, new_scene_path: String) -> void:
	if save_current_scene:
		var new_scene = last_scene.instance()
		add_child(new_scene)
	else:
		var new_scene = load(new_scene_path).instance()
		add_child(new_scene)
		last_scene = PackedScene.new()
		last_scene.pack(current_scene)
		
	
	# Add a transition
	# Call last
	current_scene.queue_free()

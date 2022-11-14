extends Node


var old_scene_path: String


func _ready() -> void:
	
	change_scene(false, Node.new(), "", "res://Scenes/Levels/LevelLobby.tscn")


func change_scene(save_current_scene: bool, current_scene: Node, current_scene_path: String, new_scene_path: String):
	# Add a tansition
	var new_scene: Node
	
	if save_current_scene:
			var saved_scene = PackedScene.new()
			saved_scene.pack(current_scene)
			EnvVar.saved_scenes[current_scene_path] = saved_scene
	
	if new_scene_path == "return":
		new_scene_path = old_scene_path
	
	if new_scene_path in EnvVar.saved_scenes:
		new_scene = EnvVar.saved_scenes[new_scene_path].instance()
	else:
		new_scene = load(new_scene_path).instance()

	add_child(new_scene)
	
	if new_scene_path != "res://Scenes/Elevator/Elevator.tscn":
		old_scene_path = new_scene_path
	current_scene.queue_free()
	print(EnvVar.saved_scenes)

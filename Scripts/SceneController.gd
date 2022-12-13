extends Node
# A scene control node for packaging, saving and switching scenes
var new_scene: Node2D

func _ready() -> void:
	
	# Sets the first scene
	change_scene(false, Node.new(), "", "res://Scenes/Levels/LevelLobby.tscn")


func change_scene(save_current_scene: bool, current_scene: Node, current_scene_path: String, new_scene_path: String):
	# TODO: Add a tansition
	
	# Now packages the scene and overwrites the old one, if it exists
	# Adds to dictionary with PackedScene as value and file path as key
	if save_current_scene:
		var saved_scene = PackedScene.new()
		saved_scene.pack(current_scene)
		EnvVar.saved_scenes[current_scene_path] = saved_scene
		EnvVar.saved_scenes_strings[current_scene.name] = current_scene_path
	
	
	# Instantiates an old scene or new scene if no old one exists
	
	if new_scene_path in EnvVar.saved_scenes:
		new_scene = EnvVar.saved_scenes[new_scene_path].instance()
	else:
		new_scene = load(new_scene_path).instance()
	
	# Adds the new scene and removes the old one
	$Transition/Animation.play("FadeIn")
	current_scene.queue_free()
	yield(get_tree().create_timer(0.2),"timeout")
	add_child(new_scene)

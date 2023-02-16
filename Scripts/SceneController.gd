extends Node
# A scene control node for packaging, saving and switching scenes
var level0_variables: Dictionary = {"player_position": Vector2.ZERO}
var level1_variables: Dictionary = {"player_position": Vector2.ZERO}
var level2_variables: Dictionary = {"player_position": Vector2.ZERO}


func _ready() -> void:
	
	# Sets the first scene
	change_scene(false, Node.new(), "", "res://Scenes/UI/MainMenu.tscn")
	EnvVar.can_pause = false


func _input(event: InputEvent) -> void:
	#----------------- DEV -----------------
	if event.is_action_pressed("dev"):
		change_scene(false, get_child(1), get_child(1).filename, "res://Scenes/Levels/TestLevel.tscn")
	#---------------------------------------

func change_scene(save_current_scene: bool, current_scene: Node, current_scene_path: String, new_scene_path: String):
	var new_scene: Node
	
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
	
	if new_scene.is_in_group("Level"):
		EnvVar.latest_level_path = new_scene.filename
	
	set_level_variables(new_scene)
	# Adds the new scene and removes the old one
	$Transition/Animation.play("FadeIn")
	current_scene.queue_free()
	yield(get_tree().create_timer(0.2),"timeout")
	add_child(new_scene)


func set_level_variables(level: Node):
	if level.name == "Level0":
		level0_variables["player_position"] = level.get_node("Navigation2D/YSort/Player").global_position
	if level.name == "Level1":
		level0_variables["player_position"] = level.get_node("Navigation2D/YSort/Player").global_position


func get_level_variables(level: Node):
	pass

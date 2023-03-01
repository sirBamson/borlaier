extends Node
# A scene control node for packaging, saving and switching scenes
var elevator_variables: Dictionary = {}
var level0_variables: Dictionary = {"player_position": Vector2(216, 1312)}
var level1_variables: Dictionary = {"player_position": Vector2(3968, 3624)}
var level2_variables: Dictionary = {"player_position": Vector2(3968, 3624)}


func _ready() -> void:
	# Sets the first scene
	change_scene(false, Node.new(), "", "res://Scenes/UI/MainMenu.tscn")


func _input(event: InputEvent) -> void:
	#----------------- DEV -----------------
	if event.is_action_pressed("dev"):
		change_scene(false, get_child(1), get_child(1).filename, "res://Scenes/Levels/TestLevel.tscn")
	#---------------------------------------


func change_scene(save_current_scene: bool, current_scene: Node, current_scene_path: String, new_scene_path: String):
	var new_scene: Node = load(new_scene_path).instance()
	
	if new_scene.is_in_group("Level"):
		EnvVar.latest_level_path = new_scene.filename
	
	if save_current_scene:
		get_level_variables(current_scene)
	
	set_level_variables(new_scene)
	
	# Adds the new scene and removes the old one
	$Transition/Animation.play("FadeIn")
	current_scene.queue_free()
	yield(get_tree().create_timer(0.2),"timeout")
	add_child(new_scene)


func get_level_variables(level: Node):
	if level.name == "Level0":
		level0_variables["player_position"] = level.get_node("Navigation2D/YSort/Player").global_position
	if level.name == "Level1":
		level1_variables["player_position"] = level.get_node("Navigation2D/YSort/Player").global_position
	if level.name == "Level2":
		level2_variables["player_position"] = level.get_node("Navigation2D/YSort/Player").global_position


func set_level_variables(level: Node):
	if level.name == "Level0":
		level.get_node("Navigation2D/YSort/Player").global_position = level0_variables["player_position"]
	if level.name == "Level1":
		level.get_node("Navigation2D/YSort/Player").global_position = level1_variables["player_position"]
	if level.name == "Level2":
		level.get_node("Navigation2D/YSort/Player").global_position = level2_variables["player_position"]

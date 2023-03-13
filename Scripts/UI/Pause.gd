extends CanvasLayer


onready var scene_controller: Node = get_node("/root/SceneController")


func _ready() -> void:
	visible = false


"""
Aktiverar pause_game() om esc tryckts
Om spelaren befinner sig på taket eller i challenge mode så kan inte spelaren spara
"""

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		var node_is_roof: bool = false
		for node in scene_controller.get_children():
			if node.is_in_group("Roof"):
				node_is_roof = true
		if EnvVar.in_challenge_run or node_is_roof:
			$VBoxContainer/VBoxContainer/SaveGame.disabled = true
		else:
			$VBoxContainer/VBoxContainer/SaveGame.disabled = false
		pause_game()


"""
Pausar/av pausar spelet
"""

func pause_game() -> void:
	if EnvVar.can_pause:
		visible = !visible
		get_tree().paused = !get_tree().paused


"""
Om ContinueGame trycks körs pause_game()
"""

func _on_ContinueGame_pressed() -> void:
	pause_game()


"""
Sparar spelet om tryckt
"""

func _on_SaveGame_pressed() -> void:
	SaveGame.save_data()


"""
Inaktiv
"""

func _on_Settings_pressed() -> void:
	SaveGame.reset_data()


"""
Om QuitToMenu trycks sparas spelet om rätt vilkor uppfylls och byter scene
"""

func _on_QuitToMenu_pressed() -> void:
	pause_game()
	for node in scene_controller.get_children():
		if node.is_in_group("Level") or node.is_in_group("Elevator"):
			if !EnvVar.in_challenge_run and !node.is_in_group("Roof"):
				SaveGame.save_data()
			scene_controller.change_scene(false, node, node.filename, "res://Scenes/UI/MainMenu.tscn")
	

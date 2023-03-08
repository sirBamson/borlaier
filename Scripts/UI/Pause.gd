extends CanvasLayer


onready var scene_controller: Node = get_node("/root/SceneController")


func _ready() -> void:
	visible = false


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		if EnvVar.in_challenge_run:
			$VBoxContainer/VBoxContainer/SaveGame.disabled = true
		else:
			$VBoxContainer/VBoxContainer/SaveGame.disabled = false
		pause_game()


func pause_game() -> void:
	if EnvVar.can_pause:
		visible = !visible
		get_tree().paused = !get_tree().paused


func _on_ContinueGame_pressed() -> void:
	pause_game()


func _on_SaveGame_pressed() -> void:
	SaveGame.save_data()


func _on_Settings_pressed() -> void:
	SaveGame.reset_data()


func _on_QuitToMenu_pressed() -> void:
	pause_game()
	if !EnvVar.in_challenge_run:
		SaveGame.save_data()
	for node in scene_controller.get_children():
		if node.is_in_group("Level") or node.is_in_group("Elevator"):
			scene_controller.change_scene(false, node, node.filename, "res://Scenes/UI/MainMenu.tscn")

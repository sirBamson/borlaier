extends Control


onready var scene_controller: Node = get_node("/root/SceneController")


func _ready() -> void:
	if !EnvVar.in_challenge_run:
		PlayerGlobals.bullets_in_mag_main = PlayerGlobals.bullets_in_mag
		PlayerGlobals.bullets_left_main = PlayerGlobals.bullets_left
	EnvVar.can_pause = false
	if EnvVar.first_time_played:
		$VBoxContainer/VBoxContainer/ContinueGame.text = "Start the gamble"
		$VBoxContainer/VBoxContainer/ChallengeRun.disabled = true
	else:
		$VBoxContainer/VBoxContainer/ContinueGame.text = "Continue game"


func _on_ContinueGame_pressed() -> void:
	PlayerGlobals.bullets_left = PlayerGlobals.bullets_left_main
	PlayerGlobals.bullets_in_mag = PlayerGlobals.bullets_in_mag_main
	
	EnvVar.in_challenge_run = false
	EnvVar.can_pause = true
	if EnvVar.first_time_played:
		EnvVar.first_time_played = false
		# Set lobby or intro
		scene_controller.change_scene(false, self, self.filename, "res://Scenes/Levels/Level0.tscn")
	elif not EnvVar.first_time_played:
		scene_controller.change_scene(false, self, self.filename, EnvVar.latest_level_path)


func _on_ChallengeRun_pressed() -> void:
	PlayerGlobals.bullets_left = 300
	
	EnvVar.can_pause = true
	EnvVar.in_challenge_run = true
	scene_controller.change_scene(false, self, self.filename, "res://Scenes/Minigames/Endless/EndlessLevel.tscn")


func _on_Settings_pressed() -> void:
	SaveGame.reset_data()


func _on_QuitToDesktop_pressed() -> void:
	get_tree().quit()

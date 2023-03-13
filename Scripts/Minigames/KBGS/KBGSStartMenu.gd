extends Control


onready var scene_controller: Node = get_node("/root/SceneController")


"""
Beroende på vilket tillfälle som start menyn körs vid sätts olika texter
"""

func _ready() -> void:
	if EnvVar.kbgs_minigame_first_time:
		$Title.text = "Kill bad guyS"
		$Music.play()
	elif EnvVar.kbgs_minigame_won:
		Stats.kgbs_times_won += 1
		$Title.text = "Victory!"
		$Victory.play()
	elif !EnvVar.kbgs_minigame_won:
		$Title.text = "Game over!"
		$GameOver.play()


"""
Byter scene beroende på den knapp som trycks
"""

func _on_Start_button_up() -> void:
	EnvVar.kbgs_minigame_first_time = false
	scene_controller.change_scene(false, self, self.filename, "res://Scenes/Minigames/KBGS/KBGSLevel.tscn")

func _on_Exit_button_up() -> void:
	EnvVar.kbgs_minigame_first_time = true
	scene_controller.change_scene(false, self, self.filename, EnvVar.minigame_load_scene_path)

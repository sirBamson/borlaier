extends Control


onready var scene_controller: Node = get_node("/root/SceneController")


func _on_Start_button_up() -> void:
	scene_controller.change_scene(false, self, self.filename, "res://Scenes/Minigames/KBGS/KBGSLevel.tscn")


func _on_Exit_button_up() -> void:
	scene_controller.change_scene(false, self, self.filename, EnvVar.minigame_load_scene)

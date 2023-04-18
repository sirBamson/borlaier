extends Control

onready var scene_controller: Node = get_node("/root/SceneController")

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("esc"):
		scene_controller.change_scene(false, self, self.filename, "res://Scenes/UI/MainMenu.tscn")

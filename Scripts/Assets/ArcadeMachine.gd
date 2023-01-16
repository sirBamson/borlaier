extends StaticBody2D


onready var scene_controller: Node = get_node("/root/SceneController")

var can_use_arcade: bool = false


func _physics_process(delta: float) -> void:
	if can_use_arcade:
		if Input.is_action_pressed("ui_accept"):
			EnvVar.minigame_load_scene = get_parent().get_parent().filename
			scene_controller.change_scene(true, get_parent().get_parent(), get_parent().get_parent().filename, "res://Scenes/Minigames/KBGS/KBGSStartMenu.tscn")



func _on_Area2D_area_entered(area: Area2D) -> void:
	if area.name == "PlayerHitbox":
		can_use_arcade = true


func _on_Area2D_area_exited(area: Area2D) -> void:
	if area.name == "PlayerHitbox":
		can_use_arcade = false

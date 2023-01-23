extends StaticBody2D

onready var scene_controller: Node = get_node("/root/SceneController")


func _physics_process(_delta: float) -> void:
	for area in $InteractionArea.get_overlapping_areas():
		
		if area.name == "PlayerHitbox":
			
			if Input.is_action_pressed("interaction"):
				
				for node in get_node("/root/SceneController").get_children():
					
					if node.is_in_group("Level"):
						EnvVar.minigame_load_scene = node.filename
						scene_controller.change_scene(true, node, node.filename, "res://Scenes/Minigames/KBGS/KBGSStartMenu.tscn")

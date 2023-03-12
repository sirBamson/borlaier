extends StaticBody2D


export (String) var minigame_path: String = ""

onready var scene_controller: Node = get_node("/root/SceneController")

var in_interaction_area: bool = false


"""
Huvudfunktion för arkad-maskinen

Kollar om spelaren är vid arkad-masiken och om "interaction" knappen är trykt
Sätter även "EnvVar.minigame_load_scene_path" för att spelet ska kunna veta vars
minigamet körs ifrån.

Gjord på ett sätt som tillåter flera olika minigames med samma kod tack vare
"minigame_path".
"""

func _physics_process(_delta: float) -> void:
	if in_interaction_area:
		if Input.is_action_pressed("interaction"):
			for node in get_node("/root/SceneController").get_children():
				if node.is_in_group("Level"):
					EnvVar.minigame_load_scene_path = node.filename
					scene_controller.change_scene(true, node, node.filename, minigame_path)


"""
Signal funktioner
"""

func _on_InteractionArea_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("Player"):
		in_interaction_area = true


func _on_InteractionArea_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group("Player"):
		in_interaction_area = false

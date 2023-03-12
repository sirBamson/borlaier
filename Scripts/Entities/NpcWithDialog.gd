extends StaticBody2D


export (String) var npc_name: String = "npc name here"


var in_quest_area: bool = false

"""
Om spelaren befinner sig i quest_area och "talk" är trykt
startas dialogic med den nuvarande npc:n
"""

func _physics_process(_delta: float) -> void:
	if in_quest_area:
		if Input.is_action_pressed("talk") and not PlayerGlobals.talking:
			PlayerGlobals.talking = true
			Dialogic.set_variable("CurrentChar", npc_name)
			add_child(Dialogic.start("Npc"))


func _on_QuestArea_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("Player"):
		in_quest_area = true


func _on_QuestArea_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group("Player"):
		in_quest_area = false

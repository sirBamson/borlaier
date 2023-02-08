extends StaticBody2D


export (String) var npc_name: String = "FatMan"


func _ready() -> void:
	for skin in $Skins.get_children():
		if skin.name == npc_name:
			skin.visible = true
		else:
			skin.visible = false


func _physics_process(_delta: float) -> void:
	for area in $QuestArea.get_overlapping_areas():
		if area.name == "PlayerHitbox":
			if Input.is_action_pressed("talk") and not PlayerGlobals.talking:
				PlayerGlobals.talking = true
				Dialogic.set_variable("CurrentChar", npc_name)
				add_child(Dialogic.start("Npc"))

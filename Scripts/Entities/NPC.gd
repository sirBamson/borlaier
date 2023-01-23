extends StaticBody2D


export (String) var skin_name: String = "Npc000"


func _ready() -> void:
	for skin in $Skins.get_children():
		if skin.name == skin_name:
			skin.visible = true
		else:
			skin.visible = false


func _physics_process(_delta: float) -> void:
	for area in $QuestArea.get_overlapping_areas():
		if area.name == "PlayerHitbox":
			if Input.is_action_pressed("talk"):
				add_child(Dialogic.start("Test"))

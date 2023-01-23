extends StaticBody2D


export (String) var skin_name: String = "Npc000"


func _ready() -> void:
	for skin in $Skins.get_children():
		if skin.name == skin_name:
			skin.visible = true
		else:
			skin.visible = false

extends Area2D


var bullets_in_pouch: int = 50
func _ready() -> void:
	$Label.text = "50"

func _on_AmmoPouch_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		if PlayerGlobals.bullets_left <= 250:
			PlayerGlobals.bullets_left += 50
			queue_free()
		else:
			bullets_in_pouch -= (300 - PlayerGlobals.bullets_left)
			PlayerGlobals.bullets_left += (300 - PlayerGlobals.bullets_left)
			$Label.text = str(bullets_in_pouch)
			if (300 - PlayerGlobals.bullets_left) > bullets_in_pouch:
					PlayerGlobals.bullets_left + bullets_in_pouch
					print(bullets_in_pouch)
					if bullets_in_pouch <= 0:
						queue_free()
					



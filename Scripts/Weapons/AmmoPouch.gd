extends Area2D


var bullets_in_pouch: int = 50
func _ready() -> void:
	$Label.text = "50"


func _on_AmmoPouch_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("Player"):
		# 300 bullets max
		while bullets_in_pouch > 0:
			if PlayerGlobals.bullets_left < 300:
				PlayerGlobals.bullets_left += 1
				bullets_in_pouch -= 1
			elif PlayerGlobals.bullets_left >= 300:
				break
		
		if bullets_in_pouch == 0:
			queue_free()
		$Label.text = str(bullets_in_pouch)



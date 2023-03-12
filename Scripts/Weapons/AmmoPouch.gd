extends Area2D

"""
Sätter amunitionen i vapenmagasinet till 50 och skriver ut det på amunitions påsen.
"""

var bullets_in_pouch: int = 50
func _ready() -> void:
	$Label.text = "50"

"""
Kollar om spelaren är inom räckvid till amunitionen, med hjälp av signalen "area_entered", 
och plockar i så fall upp så mycket amunition som går, max 50. Spelarens totala amunitionsgräns är 300. 
Skriver på amunitions påsen hur många skott som finns kvar om det är > 0, annars tas påsen bort.
"""

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



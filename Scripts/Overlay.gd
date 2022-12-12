extends CanvasLayer


func _physics_process(delta: float) -> void:
	$TextureRect/Bullets/BulletsInMag.text = "Bullets in mag: " + str(PlayerGlobals.bullets_in_mag)
	$TextureRect/Bullets/BulletsLeft.text = "Bullets left: " + str(PlayerGlobals.bullets_left)

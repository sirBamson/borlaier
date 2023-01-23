extends CanvasLayer

func _ready() -> void:
	$TextureRect/Bullets.visible = false


func _physics_process(_delta: float) -> void:
	if PlayerGlobals.player_has_gun:
		$TextureRect/Bullets.visible = true
		$TextureRect/Bullets/BulletsInMag.text = "Bullets in mag: " + str(PlayerGlobals.bullets_in_mag)
		$TextureRect/Bullets/BulletsLeft.text = "Bullets left: " + str(PlayerGlobals.bullets_left)
	else:
		$TextureRect/Bullets.visible = false

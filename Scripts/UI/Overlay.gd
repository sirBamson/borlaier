extends CanvasLayer

func _ready() -> void:
	$VBox/BulletsInMag.visible = false
	$VBox/BulletsLeft.visible = false


func _physics_process(_delta: float) -> void:
	if PlayerGlobals.has_gun:
		$VBox/BulletsInMag.visible = true
		$VBox/BulletsLeft.visible = true
		$VBox/BulletsInMag.text = "Bullets in mag: " + str(PlayerGlobals.bullets_in_mag)
		$VBox/BulletsLeft.text = "Bullets left: " + str(PlayerGlobals.bullets_left)
	else:
		$VBox/BulletsInMag.visible = false
		$VBox/BulletsLeft.visible = false
	
	$VBox/Coins.text = "Money: " + str(PlayerGlobals.coins) + "c"
	$VBox/FPS.text = "FPS: " + str(Engine.get_frames_per_second())

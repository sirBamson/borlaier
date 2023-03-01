extends CanvasLayer

func _ready() -> void:
	$VBox/Bullets.visible = false


func _physics_process(_delta: float) -> void:
	if PlayerGlobals.has_gun:
		$VBox/Bullets.visible = true
		$VBox/Bullets.text = "    : " + str(PlayerGlobals.bullets_in_mag) + " | " + str(PlayerGlobals.bullets_left)

	else:
		$VBox/Bullets.visible = false
	
	$VBox/FPS.text = "FPS: " + str(Engine.get_frames_per_second())
	$VBox/Coins.text = "    : " + str(PlayerGlobals.coins) + "c"
	$VBox/Grenades.text = "    : " + str(PlayerGlobals.grenades_left)


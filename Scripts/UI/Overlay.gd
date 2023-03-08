extends CanvasLayer

func _ready() -> void:
	$VBoxLeft/Bullets.visible = false


func _physics_process(_delta: float) -> void:
	$HealthBar.value = PlayerGlobals.health
	
	
	if PlayerGlobals.has_gun:
		$VBoxLeft/Bullets.visible = true
		$VBoxLeft/Bullets.text = "    : " + str(PlayerGlobals.bullets_in_mag) + " | " + str(PlayerGlobals.bullets_left)
	else:
		$VBoxLeft/Bullets.visible = false
	
	$VBoxLeft/FPS.text = "FPS: " + str(Engine.get_frames_per_second())
	$VBoxLeft/AccessLevel.text = "Access: Floor " + str(PlayerGlobals.elevator_floor_access.back())
	$VBoxLeft/Coins.text = "    : " + str(PlayerGlobals.coins) + "c"
	$VBoxLeft/Grenades.text = "    : " + str(PlayerGlobals.grenades_left)


extends CanvasLayer


onready var player = get_parent()

func _ready() -> void:
	$VBoxLeft/Bullets.visible = false
	PlayerGlobals.health = 100

"""
Hanterar "EndlessPlayer" overlay.
Fungerar liknade till den vanliga overlayen.
Skillnaden är att denna visar poäng.
"""

func _physics_process(_delta: float) -> void:
	$HealthBar.value = PlayerGlobals.health
	
	if player.has_gun:
		$VBoxLeft/Bullets.visible = true
		$VBoxLeft/Bullets.text = "    : " + str(PlayerGlobals.bullets_in_mag) + " | " + str(PlayerGlobals.bullets_left)
	else:
		$VBoxLeft/Bullets.visible = false
	
	$VBoxLeft/Points.text = "Points: " + str(player.points)
	$VBoxLeft/Grenades.text = "    : " + str(player.grenades_left)


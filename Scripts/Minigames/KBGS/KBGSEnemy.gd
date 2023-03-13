extends StaticBody2D


var in_detection_area: bool = false
var in_swing_area: bool = false

var player: KinematicBody2D



"""
Känner av spelar noden.
"""

func _ready() -> void:
	for node in get_parent().get_children():
		if node.is_in_group("Player"):
			player = node


"""
Vänder fienden mot spelaren om spelaren befinner sig i "in_detection_area"
"""

func _physics_process(delta: float) -> void:
	if in_detection_area:
		if global_position.x <= player.global_position.x:
			scale.x = 1
		if global_position.x > player.global_position.x:
			scale.x = -1


"""
Känner av spelaren
"""

func _on_DetectionArea_area_entered(area: Area2D) -> void:
	if area.name == "PlayerHitbox":
		in_detection_area = true
		$SwingWaitTimer.start()

func _on_DetectionArea_area_exited(area: Area2D) -> void:
	if area.name == "PlayerHitbox":
		in_detection_area = false
		$SwingWaitTimer.stop()


"""
Känner av seplaren
"""

func _on_SwingArea_area_entered(area: Area2D) -> void:
	if area.name == "PlayerHitbox":
		in_swing_area = true

func _on_SwingArea_area_exited(area: Area2D) -> void:
	if area.name == "PlayerHitbox":
		in_swing_area = false


"""
Om enemy kommer i kontakt med "PlayerPunchArea" så
queue_free:as enemy.
"""

func _on_DamageArea_area_entered(area: Area2D) -> void:
	if area.name == "PlayerPunchArea":
		player.enemy_amount -= 1
		queue_free()


"""
Aktiverar "EnemySwingArea" och startar animation
"""

func _on_SwingWaitTimer_timeout() -> void:
	$Sprite.play("default")
	$EnemySwingArea/CollisionShape.disabled = false


"""
Stopar animationen och resetar enemy spriten
Startar även om "SwingWaitTimer" om spelaren befinner sig i "in_swing_area".
"""

func _on_Sprite_animation_finished() -> void:
	$Sprite.stop()
	$EnemySwingArea/CollisionShape.disabled = true
	$Sprite.frame = 0
	
	if in_swing_area:
		$SwingWaitTimer.start()

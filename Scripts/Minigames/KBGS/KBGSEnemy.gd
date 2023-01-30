extends StaticBody2D


var in_detection_area: bool = false
var in_swing_area: bool = false

var player: KinematicBody2D


func _ready() -> void:
	for node in get_parent().get_children():
		if node.is_in_group("Player"):
			player = node


func _physics_process(delta: float) -> void:
	if in_detection_area:
		if global_position.x <= player.global_position.x:
			scale.x = 1
		if global_position.x > player.global_position.x:
			scale.x = -1




func _on_DetectionArea_area_entered(area: Area2D) -> void:
	if area.name == "PlayerHitbox":
		in_detection_area = true
		$SwingWaitTimer.start()

func _on_DetectionArea_area_exited(area: Area2D) -> void:
	if area.name == "PlayerHitbox":
		in_detection_area = false
		$SwingWaitTimer.stop()


func _on_SwingArea_area_entered(area: Area2D) -> void:
	if area.name == "PlayerHitbox":
		in_swing_area = true

func _on_SwingArea_area_exited(area: Area2D) -> void:
	if area.name == "PlayerHitbox":
		in_swing_area = false


func _on_DamageArea_area_entered(area: Area2D) -> void:
	if area.name == "PlayerPunchArea":
		player.enemy_amount -= 1
		queue_free()


func _on_SwingWaitTimer_timeout() -> void:
	$Sprite.play("default")
	$EnemySwingArea/CollisionShape.disabled = false


func _on_Sprite_animation_finished() -> void:
	$Sprite.stop()
	$EnemySwingArea/CollisionShape.disabled = true
	$Sprite.frame = 0
	
	if in_swing_area:
		$SwingWaitTimer.start()

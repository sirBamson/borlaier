extends AnimatedSprite


var in_hit_area_right: bool = false
var in_hit_area_left: bool = false
var in_enemy_hit_area: bool = false

var player: Node

func _physics_process(delta: float) -> void:
	if !in_hit_area_right and !in_hit_area_left:
		$HitWaitTimer.stop()


func _on_DetectionLeft_area_entered(area: Area2D) -> void:
	if area.name == "PlayerHitbox":
		player = area.get_parent()
		scale.x = -1.5
		$EnemyHit.scale.x = 1
		$HitWaitTimer.start(0.5)
		in_hit_area_left = true


func _on_DetectionLeft_area_exited(area: Area2D) -> void:
	if area.name == "PlayerHitbox":
		in_hit_area_left = false


func _on_DetectionRight_area_entered(area: Area2D) -> void:
	if area.name == "PlayerHitbox":
		player = area.get_parent()
		scale.x = 1.5
		$EnemyHit.scale.x = -1
		$HitWaitTimer.start(0.5)
		in_hit_area_right = true


func _on_DetectionRight_area_exited(area: Area2D) -> void:
	if area.name == "PlayerHitbox":
		in_hit_area_right = false


func _on_EnemyHit_area_entered(area: Area2D) -> void:
	in_enemy_hit_area = true


func _on_EnemyHit_area_exited(area: Area2D) -> void:
	in_enemy_hit_area = false


func _on_HitWaitTimer_timeout() -> void:
	if in_enemy_hit_area:
		player.hit()
		play("defult")


func _on_Enemy_animation_finished() -> void:
	stop()
	frame = 0
	if in_hit_area_right or in_hit_area_left:
		$HitWaitTimer.start(0.5)


func hit() -> void:
	queue_free()

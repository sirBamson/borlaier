extends RigidBody2D

var throw_speed = 1200


func _ready() -> void:
	visible = true
	look_at(get_global_mouse_position())
	apply_impulse(Vector2.ZERO, Vector2(throw_speed, 0).rotated(rotation))
	$Timer.start(1.5)
	$Area2D/CollisionShape2D.disabled = true
	$Area2D/AnimatedSprite.visible = false
	


func grenade_explosion():
	$Timer.stop()
	$Sprite.visible = false
	sleeping = true
	$Area2D/CollisionShape2D.disabled = false
	$Area2D/AnimatedSprite.visible = true
	$Area2D/AnimatedSprite.play("default")

func _on_Timer_timeout() -> void:
	grenade_explosion()


func _on_AnimatedSprite_animation_finished() -> void:
	queue_free()

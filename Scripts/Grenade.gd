extends RigidBody2D

export (int) var throw_speed: int = 1200

var grenade_exploded: bool = false
var thrown_once: bool = false


func _ready() -> void:
	visible = true
	$PinPull.play()
	$Timer.start(2)
	$Area2D/CollisionShape2D.disabled = true
	$Area2D/AnimatedSprite.visible = false


func grenade_explosion():
	$Timer.stop()
	$Sprite.visible = false
	sleeping = true
	$GrenadeExplosion.play()
	$Area2D/CollisionShape2D.disabled = false
	$Area2D/AnimatedSprite.visible = true
	$Area2D/AnimatedSprite.play("default")


func grenade_thrown() -> void:
	if not grenade_exploded and not thrown_once:
		thrown_once = true
		look_at(get_global_mouse_position())
		apply_impulse(Vector2.ZERO, Vector2(throw_speed, 0).rotated(rotation))


func _on_Timer_timeout() -> void:
	grenade_exploded = true
	grenade_explosion()


func _on_GrenadeExplosion_finished() -> void:
	queue_free()

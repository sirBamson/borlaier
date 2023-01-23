extends RigidBody2D

export (int) var throw_speed: int = 1200

var player: Node

var grenade_exploded: bool = false
var thrown: bool = false


func _ready() -> void:
	visible = true
	$PinPull.play()
	$Timer.start(2)
	$Area2D/CollisionShape2D.disabled = true
	$Area2D/AnimatedSprite.visible = false


func _physics_process(_delta: float) -> void:
	if PlayerGlobals.holding_grenade and !thrown:
		global_position = player.global_position - Vector2(0, 120)


func grenade_explosion():
	$Timer.stop()
	$Sprite.visible = false
	sleeping = true
	$GrenadeExplosion.play()
	$Area2D/CollisionShape2D.disabled = false
	$Area2D/AnimatedSprite.visible = true
	$Area2D/AnimatedSprite.play("default")


func grenade_thrown() -> void:
	if not grenade_exploded and not thrown:
		thrown = true
		look_at(get_global_mouse_position())
		apply_impulse(Vector2.ZERO, Vector2(throw_speed, 0).rotated(rotation))
		

func _on_Timer_timeout() -> void:
	grenade_exploded = true
	grenade_explosion()
	Shake.start_shake(8, 0.4)


func _on_GrenadeExplosion_finished() -> void:
	queue_free()

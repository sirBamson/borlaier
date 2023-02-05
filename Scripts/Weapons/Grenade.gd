extends RigidBody2D

export (int) var throw_speed: int = 1200
export (int) var drag: int = 500
export (int) var damage_output: int = 50

var player: Node

var grenade_exploded: bool = false
var thrown: bool = false


func _ready() -> void:
	visible = true
	$PinPull.play()
	$Timer.start(2)
	$DamageArea/CollisionShape.disabled = true
	$DamageArea/AnimatedSprite.visible = false


func _physics_process(_delta: float) -> void:
	if PlayerGlobals.holding_grenade and !thrown:
		global_position = player.global_position - Vector2(0, 120)


func grenade_explosion():
	$Timer.stop()
	$Sprite.visible = false
	sleeping = true
	$GrenadeExplosion.play()
	$CollisionShape.disabled = true
	$DamageArea/CollisionShape.disabled = false
	$DamageArea/AnimatedSprite.visible = true
	$DamageArea/AnimatedSprite.play("default")


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


func _on_AnimatedSprite_animation_finished() -> void:
	$DamageArea/CollisionShape.disabled = true

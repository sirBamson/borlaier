extends RigidBody2D

onready var explosion = preload("res://Scenes/Weapons/GrenadeExplosion.tscn")

var throw_speed = 800
var grenade_count = 2

func _ready() -> void:
	self.visible = false

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("ThrowGrenade") and grenade_count > 0:
		grenade_count -= 1
		self.visible = true
		apply_impulse(Vector2.ZERO, Vector2(throw_speed, 0).rotated(rotation))
		$Timer.start(1.5)
		

func grenade_explosion():
	$Timer.stop()
	queue_free()
	

func _on_Timer_timeout() -> void:
	grenade_explosion()

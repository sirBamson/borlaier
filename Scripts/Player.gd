extends KinematicBody2D

var _direction: Vector2 = Vector2.ZERO
var _velocity: Vector2 = Vector2.ZERO
#var bullet_speed = 2000
#var bullet = preload("res://scenes/bullet.tscn")

export var speed = 250


func _physics_process(_delta: float) -> void:
	_movment()


func _movment() -> void:
	_velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		_velocity += Vector2.UP
	if Input.is_action_pressed("ui_down"):
		_velocity += Vector2.DOWN
	if Input.is_action_pressed("ui_right"):
		_velocity += Vector2.RIGHT
	if Input.is_action_pressed("ui_left"):
		_velocity += Vector2.LEFT
	
	_direction = _velocity
	
	if _direction.x > 0:
		$PlayerSprite.play("Right")
	elif _direction.x < 0:
		$PlayerSprite.play("Left")
	elif _direction.y > 0:
		$PlayerSprite.play("Right")
	elif _direction.y < 0:
		$PlayerSprite.play("Right")
	else:
		$PlayerSprite.play("Idle")
	
	_velocity = _velocity.normalized() * speed
	_velocity = move_and_slide(_velocity)



#func fire():
#	var bullet_instance = bullet.instance()
#	bullet_instance.position = get_global_mouse_position()
#	bullet_instance.rotation_degrees = rotation_degrees
#	bullet_instance.apply_impulse(Vector2())

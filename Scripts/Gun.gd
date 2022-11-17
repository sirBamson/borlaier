extends Sprite


var bullet = preload("res://Scenes/Bullet.tscn")
export var bullet_speed = 10


func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("fire"):
		var bullet_instance = bullet.instance()
		bullet_instance.position = get_global_position() + (Vector2(0, -2).rotated(rotation))
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(bullet_instance)

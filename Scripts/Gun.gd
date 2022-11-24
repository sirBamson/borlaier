extends Sprite


export var bullet_speed = 1000
export var fire_rate = 0.12

var bullet = preload("res://Scenes/Bullet.tscn")
var can_fire = true
var a = 0
#var gun_position = $"/root/PlayerGlobals"
#var dif = Vector2(200)


func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	var bullet_instance = bullet.instance()
	
	if Input.is_action_pressed("fire") and can_fire:
		bullet_instance.position = get_global_position() + (Vector2(23, -4).rotated(rotation))
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		yield(get_tree().create_timer(fire_rate),"timeout")
		can_fire = true
		
		


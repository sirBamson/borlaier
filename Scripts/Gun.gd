extends Sprite

export (int) var bullet_speed = 1000
export (int) var magasine_size = 20
export (float) var fire_rate = 0.12
export (int) var damage = 10
export (bool) var auto = false


var bullet = load("res://Scenes/Bullet.tscn")
var can_fire: bool = true
var fire_pressed: bool = false

func _ready() -> void:
	PlayerGlobals.magazine_size = magasine_size
	PlayerGlobals.bullets_in_mag = magasine_size



func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	if get_global_mouse_position().x < global_position.x:
		scale = Vector2(1, -1)
	else:
		scale = Vector2(1, 1)
	
	
	if Input.is_action_just_pressed("reload") and PlayerGlobals.bullets_in_mag < 25 and PlayerGlobals.bullets_left > 0 and can_fire:
		#PlayerGlobals.bullets_left += PlayerGlobals.bullets_in_mag
		
		$GunReloadSound.play()
		for i in range(magasine_size): 
			if PlayerGlobals.bullets_left != 0 and !PlayerGlobals.bullets_in_mag >= 25:
				PlayerGlobals.bullets_left -= 1
				PlayerGlobals.bullets_in_mag += 1
		
		can_fire = false
		yield(get_tree().create_timer(1.5),"timeout")
		can_fire = true
	
	
	if Input.is_action_pressed("fire") and can_fire and PlayerGlobals.bullets_in_mag > 0:
		
		PlayerGlobals.bullets_in_mag -= 1
		$BulletSound.play()
		var bullet_instance = bullet.instance()
		bullet_instance.global_position = $BulletSpawn.global_position
		bullet_instance.rotation = rotation
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_node("/root/SceneController").get_child(1).add_child(bullet_instance)
		
		# Regulates rate of fire
		can_fire = false
		yield(get_tree().create_timer(fire_rate),"timeout")
		can_fire = true
	
	elif Input.is_action_pressed("fire") and can_fire and PlayerGlobals.bullets_in_mag == 0:
		
		$GunClickSound.play()
		
		# Regulates rate of fire
		can_fire = false
		yield(get_tree().create_timer(fire_rate),"timeout")
		can_fire = true

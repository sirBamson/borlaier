extends Node2D


export (int) var bullet_speed: int = 3000
export (int) var magazine_size: int = 20
export (float) var fire_rate: float = 0.12
export (int) var damage: int = 10
export (bool) var auto: bool = false



var bullets_in_mag: int


var bullet = load("res://Scenes/Weapons/Bullet.tscn")
var can_fire: bool = true
var can_fire_auto: bool = true


func _input(event: InputEvent) -> void:

	if event.is_action_released("fire"):
		can_fire_auto = true

"""
Samma princip som vapenscriptet men har fler bullet_spawn's och en animation som spelas när den skjuter.
"""

func _physics_process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	
	
	if get_global_mouse_position().x < global_position.x:
		scale = Vector2(1, -1)
	else:
		scale = Vector2(1, 1)
	
	
	if auto:
		can_fire_auto = true
	
	
	if Input.is_action_just_pressed("reload") and bullets_in_mag < magazine_size and PlayerGlobals.bullets_left > 0 and can_fire:
		
		$GunReloadSound.play()
		reload_gun()
		
		can_fire = false
		yield(get_tree().create_timer(1.5),"timeout")
		can_fire = true
	
	
	if Input.is_action_pressed("fire") and can_fire and can_fire_auto and bullets_in_mag > 0 and not PlayerGlobals.talking:
		can_fire_auto = false
		
		$Minigun.play("default")
		
		bullets_in_mag -= 3
		Stats.bullets_fired += 3
		$BulletSound.play()
		$MuzzleFlash.frame = 0
		$MuzzleFlash.play("deafult")
		$BulletSound.play()
		$MuzzleFlash2.frame = 0
		$MuzzleFlash2.play("deafult")
		$BulletSound.play()
		$MuzzleFlash3.frame = 0
		$MuzzleFlash3.play("deafult")
		
		var bullet_instance = bullet.instance()
		bullet_instance.global_position = $BulletSpawn.global_position
		bullet_instance.rotation = rotation
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		bullet_instance.damage_output = damage
		get_parent().get_parent().add_child(bullet_instance)
		
		bullet_instance.global_position = $BulletSpawn2.global_position
		bullet_instance.rotation = rotation
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		bullet_instance.damage_output = damage
		get_parent().get_parent().add_child(bullet_instance)
		
		bullet_instance.global_position = $BulletSpawn3.global_position
		bullet_instance.rotation = rotation
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		bullet_instance.damage_output = damage
		get_parent().get_parent().add_child(bullet_instance)
		
		
		# Regulates rate of fire
		can_fire = false
		yield(get_tree().create_timer(fire_rate),"timeout")
		can_fire = true
	
	elif Input.is_action_pressed("fire") and can_fire and can_fire_auto and bullets_in_mag == 0:
		can_fire_auto = false
		
		$GunClickSound.play()
		
		# Regulates rate of fire
		can_fire = false
		yield(get_tree().create_timer(fire_rate),"timeout")
		can_fire = true
	
	PlayerGlobals.bullets_in_mag = bullets_in_mag



func reload_gun() -> void:
	for _i in range(magazine_size): 
		if PlayerGlobals.bullets_left != 0 and !bullets_in_mag >= magazine_size:
			PlayerGlobals.bullets_left -= 1
			bullets_in_mag += 1


func _on_Minigun_animation_finished() -> void:
	$Minigun.stop()
	$Minigun.frame = 0

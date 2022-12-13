extends KinematicBody2D

signal player_dead


var looking_direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO
var last_velocity: Vector2 = Vector2.RIGHT
var on_weapon = false

var healt: int = PlayerGlobals.player_healt

export (int) var speed: int = 600

#drop gun
func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("drop") and PlayerGlobals.player_has_gun:
		var dropped_weapon = load("res://Scenes/Weapons/DroppedWeapon.tscn")
		PlayerGlobals.player_has_gun = false
		$AssultRifle.queue_free()
		dropped_weapon = dropped_weapon.instance()
		dropped_weapon.global_position = global_position
		get_parent().add_child(dropped_weapon)
	
	
	if Input.is_action_pressed("pick_up") and on_weapon:
		var weapon = preload("res://Scenes/Weapons/AssultRifle.tscn")
		PlayerGlobals.player_has_gun = true
		get_parent().get_node("DroppedWeapon").queue_free()
		weapon = weapon.instance()
		add_child(weapon)
		weapon.global_position = global_position + Vector2(0, -121)
		
		
	
	_movment()


func _movment() -> void:
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		velocity += Vector2.UP
	if Input.is_action_pressed("ui_down"):
		velocity += Vector2.DOWN
	if Input.is_action_pressed("ui_right"):
		velocity += Vector2.RIGHT
	if Input.is_action_pressed("ui_left"):
		velocity += Vector2.LEFT
	
	
	# Uses two different movement scripts if player has a weapon or not
	
	# This script if the player has weapons
	if PlayerGlobals.player_has_gun:
		if get_global_mouse_position().x < global_position.x:
			looking_direction = Vector2.LEFT
		else:
			looking_direction = Vector2.RIGHT
		
		if velocity != Vector2.ZERO:
			if looking_direction == Vector2.LEFT:
				$PlayerSprite.play("NoHandsLeft")
			elif looking_direction == Vector2.RIGHT:
				$PlayerSprite.play("NoHandsRight")
		else:
			if looking_direction == Vector2.LEFT:
				$PlayerSprite.play("NoHandsIdleLeft")
			elif looking_direction == Vector2.RIGHT:
				$PlayerSprite.play("NoHandsIdleRight")
	
	# This script if the player has no weapons
	else:
		if velocity != Vector2.ZERO:
			
			if velocity.x != 0:
				last_velocity.x = velocity.x
		
			if last_velocity.x == -1:
				$PlayerSprite.play("Left")
			elif last_velocity.x == 1:
				$PlayerSprite.play("Right")
			
		elif velocity == Vector2.ZERO:
			if last_velocity.x == -1:
				$PlayerSprite.play("IdleLeft")
			elif last_velocity.x == 1:
				$PlayerSprite.play("IdleRight")
	
	
	velocity = velocity.normalized() * speed
	velocity = move_and_slide(velocity)


# Temp func
func take_damage(damage) -> void:
	healt -= damage
	
	if healt <= 0:
		emit_signal("player_dead")


func _on_PlayerHitbox_area_entered(area: Area2D) -> void:
	if area.name == "DroppedWeapon":
		on_weapon = true

func _on_PlayerHitbox_area_exited(area: Area2D) -> void:
	if area.name == "DroppedWeapon":
		on_weapon = false
		

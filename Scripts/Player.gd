extends KinematicBody2D


signal player_dead

var looking_direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO
var last_velocity: Vector2 = Vector2.RIGHT

var healt: int = PlayerGlobals.player_healt

export var speed: int = 250


func _physics_process(_delta: float) -> void:
	# --------------- DEV ---------------
	$BulletsInMag.text = str(PlayerGlobals.bullets_in_mag)
	$BulletsLeft.text = str(PlayerGlobals.bullets_left)
	# -----------------------------------
	
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
	
	# one with gun and one without
	
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
		
	else:
		if velocity != Vector2.ZERO:
			
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

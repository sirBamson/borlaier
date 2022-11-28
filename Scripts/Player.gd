extends KinematicBody2D


signal player_dead

var direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO
var healt: int = PlayerGlobals.player_healt
var has_gun: bool = false

export var speed = 250


func _ready() -> void:
	for child in get_children():
		if child.name == "Gun":
			has_gun = true


func _physics_process(_delta: float) -> void:
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
	
	
	direction = velocity
	
	if has_gun and direction != Vector2.ZERO:
		if get_global_mouse_position().x < global_position.x:
			direction.x = -1
		else:
			direction.x = 1
	elif has_gun:
		if get_global_mouse_position().x < global_position.x:
			$PlayerSprite.play("NoHandsIdleLeft")
		else:
			$PlayerSprite.play("NoHandsIdleRight")
	
	
	if direction.x > 0:
		$PlayerSprite.play("NoHandsRight")
	elif direction.x < 0:
		$PlayerSprite.play("NoHandsLeft")
	elif direction.y > 0:
		$PlayerSprite.play("NoHandsRight")
	elif direction.y < 0:
		$PlayerSprite.play("NoHandsRight")
	elif !has_gun:
		$PlayerSprite.play("NoHandsIdleRight")
	
	velocity = velocity.normalized() * speed
	velocity = move_and_slide(velocity)


func take_damage(damage) -> void:
	healt -= damage
	
	if healt <= 0:
		emit_signal("player_dead")

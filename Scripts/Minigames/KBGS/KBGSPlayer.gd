extends KinematicBody2D


var health: int = 100
var walk_speed: int = 400
var gravity: int = 1500
var jump_force: int = 900

var velocity: Vector2 = Vector2.ZERO
var last_velocity: Vector2 = Vector2(-1, 0)


func _physics_process(delta: float) -> void:
	movement()


func movement() -> void:
	$Idle.visible = false
	$Walk.visible = false
	$Jump.visible = false
	$Hit.visible = false
	
	velocity.x = 0
	velocity.y += get_physics_process_delta_time() * gravity
	
	if Input.is_action_pressed("mini_right"):
		velocity += Vector2.RIGHT
	if Input.is_action_pressed("mini_left"):
		velocity += Vector2.LEFT
	if Input.is_action_pressed("mini_jump") and is_on_floor():
		velocity.y += -jump_force
	
	
	if velocity.x != 0 or !is_on_floor():
		
		if velocity.x != 0:
			last_velocity.x = velocity.x
		
		if last_velocity.x == -1:
			if !is_on_floor():
				$Walk.visible = false
				$Jump.visible = true
				$Jump.flip_h = false
				$Jump.play("Jump")
			else:
				$Jump.visible = false
				$Walk.visible = true
				$Walk.flip_h = false
				$Walk.play("Walk")
		elif last_velocity.x == 1:
			if !is_on_floor():
				$Walk.visible = false
				$Jump.visible = true
				$Jump.flip_h = true
				$Jump.play("Jump")
			else:
				$Jump.visible = false
				$Walk.visible = true
				$Walk.flip_h = true
				$Walk.play("Walk")
		
	elif velocity.x == 0:
		if last_velocity.x == -1:
			$Jump.visible = false
			$Idle.visible = true
			$Idle.flip_h = false
			$Idle.play("Idle")
		elif last_velocity.x == 1:
			$Jump.visible = false
			$Idle.visible = true
			$Idle.flip_h = true
			$Idle.play("Idle")
	
	velocity.x = velocity.x * walk_speed
	
	velocity = move_and_slide(velocity, Vector2.UP)

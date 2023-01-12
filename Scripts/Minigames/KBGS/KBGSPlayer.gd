extends KinematicBody2D


var health: int = 100
var speed: int = 400
var velocity: Vector2 = Vector2.ZERO
var last_velocity: Vector2 = Vector2(-1, 0)


func _ready() -> void:
	$Idle.visible = true


func _physics_process(delta: float) -> void:
	movement()


func movement() -> void:
	$Idle.visible = false
	$Walk.visible = false
	$Jump.visible = false
	$Hit.visible = false
	
	
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		velocity += Vector2.RIGHT
	if Input.is_action_pressed("ui_left"):
		velocity += Vector2.LEFT
	
	
	if velocity != Vector2.ZERO:
		
		if velocity.x != 0:
			last_velocity.x = velocity.x
	
		if last_velocity.x == -1:
			$Walk.visible = true
			$Walk.flip_h = false
			$Walk.play("Walk")
		elif last_velocity.x == 1:
			$Walk.visible = true
			$Walk.flip_h = true
			$Walk.play("Walk")
		
	elif velocity == Vector2.ZERO:
		if last_velocity.x == -1:
			$Idle.visible = true
			$Idle.flip_h = false
			$Idle.play("Idle")
		elif last_velocity.x == 1:
			$Idle.visible = true
			$Idle.flip_h = true
			$Idle.play("Idle")

	
	velocity = velocity.normalized() * speed
	velocity = move_and_slide(velocity)

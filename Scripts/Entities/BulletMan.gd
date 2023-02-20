extends KinematicBody2D

export var enemy_type: String
export var speed: int = 400
export var healt: int = 250

onready var player: KinematicBody2D = get_parent().get_parent().get_node("Player")

var target_position: Vector2 = Vector2.ZERO


func _ready() -> void:
	target_position = player.global_position
	$TargetArea.global_position = target_position
	rotation = global_position.angle_to_point(target_position) + deg2rad(-90)


func _physics_process(delta: float) -> void:
	$TargetArea.global_position = target_position
	move()



func move() -> void:
	var velocity: Vector2 = Vector2.ZERO
	var direction: Vector2 = global_position.direction_to(target_position)
	velocity = direction * speed
	velocity = move_and_slide(velocity)


func _on_TargetArea_body_entered(body: Node) -> void:
	if body.name == "BulletMan":
		$PauseTimer.start(2)


func _on_PauseTimer_timeout() -> void:
	target_position = player.global_position
	$TargetArea.global_position = target_position
	rotation = global_position.angle_to_point(target_position) + deg2rad(-90)

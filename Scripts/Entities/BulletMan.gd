extends KinematicBody2D

export var enemy_type: String
export var speed: int = 400
export var healt: int = 250

onready var player: KinematicBody2D = get_parent().get_node("Player")

var target_position: Vector2 = Vector2.ZERO
var on_target: bool = false


func _ready() -> void:
	generate_target_position()
	$TargetArea.global_position = target_position
	rotation = global_position.angle_to_point(target_position) + deg2rad(-90)


func _physics_process(delta: float) -> void:
	$TargetArea.global_position = target_position
	if !on_target:
		move()


func move() -> void:
	var velocity: Vector2 = Vector2.ZERO
	var direction: Vector2 = global_position.direction_to(target_position)
	velocity = direction * speed
	velocity = move_and_slide(velocity)


func generate_target_position() -> void:
	var random: RandomNumberGenerator = RandomNumberGenerator.new()
	random.randomize()
	var angle: int = random.randi_range(0, 360)
	var radius: int = 20000
	target_position = player.global_position + Vector2(sqrt(radius) * cos(deg2rad(angle)), sqrt(radius) * sin(deg2rad(angle)))


func _on_TargetArea_body_entered(body: Node) -> void:
	if body.name == "BulletMan":
		on_target = true
		$PauseTimer.start(1)


func _on_PauseTimer_timeout() -> void:
	generate_target_position()
	$TargetArea.global_position = target_position
	on_target = false
	rotation = global_position.angle_to_point(target_position) + deg2rad(-90)


func _on_DetectionArea_area_entered(area: Area2D) -> void:
	if area.name == "PlayerHitbox":
		# Explode
		PlayerGlobals.health -= 80
		queue_free()

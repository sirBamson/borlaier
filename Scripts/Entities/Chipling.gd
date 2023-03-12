extends KinematicBody2D

export var speed: int = 250
export var health: int = 100

var colors: Array = ["Blue", "Green", "Red"]
var color: String = colors[randi() % colors.size()]

onready var player: KinematicBody2D
onready var agent: NavigationAgent2D = $NavigationAgent2D
onready var nav_timer: Timer = $NavTimer
onready var attack_timer: Timer = $AttackTimer
onready var detection_ray_1: RayCast2D = $DetectionRay1
onready var detection_ray_2: RayCast2D = $DetectionRay2
onready var detection_area: Area2D = $DetectionArea
onready var animated_sprite: AnimatedSprite = $AnimatedSprite

onready var dead_chipling: Resource = load("res://Scenes/Entities/DeadChipling.tscn")

var velocity: Vector2 = Vector2.ZERO

var target_position: Vector2 = Vector2.ZERO

# Accepted states: Idling, Hunting
var state: String = "Hunting"
var one_shot: bool = false

func _ready() -> void:
	randomize()
	animated_sprite.frame = 0
	
	for node in get_parent().get_children():
		if node.is_in_group("Player"):
			player = node
	
	match color:
		"Red":
			health = 25
			$HealthBar.max_value = 25
		"Blue":
			health = 50
			$HealthBar.max_value = 50
		"Green":
			health = 75
			$HealthBar.max_value = 75
		"Black":
			health = 100
			$HealthBar.max_value = 100


func _physics_process(delta: float) -> void:
	$HealthBar.value = health
	if health <= 0:
		if !one_shot:
			one_shot = true
			Stats.chiplings_killed += 1
			if !EnvVar.in_challenge_run:
				PlayerGlobals.coins += 2
		var dead_chipling_instance: Node2D = dead_chipling.instance()
		dead_chipling_instance.color = color
		dead_chipling_instance.global_position = global_position
		get_parent().add_child(dead_chipling_instance)
		queue_free()
	
	set_state()
	
	if state == "Hunting":
		if detection_ray_1.cast_to.x <= 0:
			animated_sprite.scale.x = -0.5
		elif detection_ray_1.cast_to.x > 0:
			animated_sprite.scale.x = 0.5
		
		animated_sprite.play(color)
		target_position = player.global_position
	elif state == "Idling":
		animated_sprite.stop()
		animated_sprite.frame = 0
		target_position = global_position
		
	move()


func move() -> void:
	if agent.is_navigation_finished():
		return
	
	var direction: Vector2 = global_position.direction_to(agent.get_next_location())
	velocity= Vector2.ZERO
	
	velocity = direction.normalized() * speed
	agent.set_velocity(velocity)


func set_state() -> void:
	detection_ray_1.add_exception(player)
	detection_ray_2.add_exception(player)
	detection_ray_1.cast_to = player.get_node("EnemyDetectionNode1").global_position - global_position
	detection_ray_2.cast_to = player.get_node("EnemyDetectionNode2").global_position - global_position
	
	
	if detection_ray_1.get_collider() == player.get_node("PlayerHitbox") or detection_ray_2.get_collider() == player.get_node("PlayerHitbox"):
		state = "Hunting"
	elif player.get_node("PlayerHitbox") in detection_area.get_overlapping_areas():
		state = "Hunting"
	else:
		state = "Idling"


func _on_NavigationAgent2D_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = move_and_slide(velocity)


func _on_DamageArea_body_entered(body: Node) -> void:
	if body.is_in_group("Bullet"):
		health -= body.damage_output
		body.queue_free()


func _on_DamageArea_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("Grenade"):
		health -= area.get_parent().damage_output
	
	if area.get_parent().is_in_group("Player"):
		attack_timer.start()
	
	if area.get_parent().is_in_group("BulletMan"):
		health = 0


func _on_DamageArea_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group("Player"):
		attack_timer.stop()


func _on_NavTimer_timeout() -> void:
	agent.set_target_location(target_position)


func _on_AttackTimer_timeout() -> void:
	PlayerGlobals.health -= 25

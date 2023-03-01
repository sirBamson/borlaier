extends KinematicBody2D

export var enemy_type: String
export var speed: int = 400
export var healt: int = 250

onready var player: KinematicBody2D = get_parent().get_node("Player")

var target_position: Vector2 = Vector2.ZERO
var on_target: bool = false

var ammo_pouch: Resource = load("res://Scenes/Weapons/AmmoPouch.tscn")

func _ready() -> void:
	randomize()
	generate_target_position()
	rotation = global_position.angle_to_point(target_position) + deg2rad(-90)


func _physics_process(delta: float) -> void:
	if healt <= 0:
		var ammo_pouch_instance: Area2D = ammo_pouch.instance()
		ammo_pouch_instance.global_position = global_position
		get_parent().add_child(ammo_pouch_instance)
		speed = 0
		$AnimatedSprite.play("explosion")
		
	
	
	if global_position.distance_to(target_position) < 10 and !on_target:
		on_target = true
		$PauseTimer.start(randi() % 3 + 1)
	
	elif !on_target:
		on_target = false
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


func _on_PauseTimer_timeout() -> void:
	generate_target_position()
	on_target = false
	rotation = global_position.angle_to_point(target_position) + deg2rad(-90)


func _on_DetectionArea_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("Player"):
		# Explode
		PlayerGlobals.health -= 80
		speed = 0
		$AnimatedSprite.play("explosion")
	
	if area.get_parent().is_in_group("Grenade"):
		healt -= area.get_parent().damage_output


func _on_DetectionArea_body_entered(body: Node) -> void:
	if body.is_in_group("Bullet"):
		healt -= body.damage_output
		body.queue_free()


func _on_AnimatedSprite_animation_finished() -> void:
	if $AnimatedSprite.animation == "explosion":
		queue_free()

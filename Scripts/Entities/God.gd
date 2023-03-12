extends Area2D

var speed: int = 10
var velocity: int = 0
var health: int = 1000

var player: KinematicBody2D
var spawner1: Position2D = get_parent().get_node("EnemySpawner")

var target_x_position: int

func _ready() -> void:
	randomize()
	
	PlayerGlobals.talking = true
	add_child(Dialogic.start("God"))
	
	for node in get_parent().get_children():
		if node.is_in_group("Player"):
			player = node
	
	target_x_position = player.global_position.x
	global_position.y = player.global_position.y - get_viewport().size.y
	global_position.x = target_x_position



func _physics_process(delta: float) -> void:
	$HealthBar.value = health
	
	if health <= 0:
		print("YOU WIN")
	
	velocity = 0
	if global_position.x - target_x_position >= 0:
		velocity =  -1 * speed 
	if global_position.x - target_x_position < 0:
		velocity = 1 * speed
	
	global_position.y = player.global_position.y - get_viewport().size.y
	global_position.x += velocity
	
	if Vector2(target_x_position, global_position.y).distance_to(global_position) < 20:
		generate_target_x_position()


func generate_target_x_position() -> void:
	var random: RandomNumberGenerator = RandomNumberGenerator.new()
	random.randomize()
	
	var acceptedXRange = get_viewport().size.x / 2
	target_x_position = player.global_position.x + random.randi_range(-acceptedXRange, acceptedXRange)
	
	if Vector2(target_x_position, global_position.y).distance_to(global_position) < 20:
		generate_target_x_position()


func dialog_done():
	PlayerGlobals.talking = false
	spawner1.active = true


func _on_God_body_entered(body: Node) -> void:
	if body.is_in_group("Bullet"):
		health -= body.damage_output
		body.queue_free()

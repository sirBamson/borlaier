extends Area2D

var speed: int = 10
var velocity: int = 0
var health: int = 2000

var player: KinematicBody2D
onready var spawner1: Position2D = get_parent().get_node("EnemySpawner")
onready var spawner2: Position2D = get_parent().get_node("EnemySpawner2")
onready var spawner3: Position2D = get_parent().get_node("EnemySpawner3")
onready var scene_controller: Node = get_node("/root/SceneController")

var lightning = load("res://Scenes/Entities/Lightning/LightningStrike.tscn")
var lightning_bolt = load("res://Scenes/Entities/Lightning/LightningBolt.tscn")

var target_x_position: int


"""
Startar dialog
Sätter första rörelse positioner
"""

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
	
	$ElevatorTimer.start()


"""
Kollar om gud är död och kör slut scenen då
Sköter guds rörelser fram och tillbaka
"""

func _physics_process(delta: float) -> void:
	$HealthBar.value = health
	
	if health <= 0:
		var current_scene: Node = get_parent()
		var current_scene_path: String = current_scene.filename
		scene_controller.level0_variables["player_position"] = Vector2(216, 1312)
		scene_controller.change_scene(true, current_scene, current_scene_path, "res://Scenes/Levels/Level0.tscn")
	
	velocity = 0
	if global_position.x - target_x_position >= 0:
		velocity =  -1 * speed 
	if global_position.x - target_x_position < 0:
		velocity = 1 * speed
	
	global_position.y = player.global_position.y - get_viewport().size.y
	global_position.x += velocity
	
	if Vector2(target_x_position, global_position.y).distance_to(global_position) < 20:
		generate_target_x_position()


"""
Genererar nya positioner för gud att röra sig till
"""

func generate_target_x_position() -> void:
	var random: RandomNumberGenerator = RandomNumberGenerator.new()
	random.randomize()
	
	var acceptedXRange = get_viewport().size.x / 2
	target_x_position = player.global_position.x + random.randi_range(-acceptedXRange, acceptedXRange)
	
	if Vector2(target_x_position, global_position.y).distance_to(global_position) < 20:
		generate_target_x_position()


"""
Ska förstöra hissen när dialogen är klar
"""
func destroy_elevator():
	pass


"""
Lägger till lightning på spelarens position
"""

func spawn_lightning():
	var lightning_instance = lightning.instance()
	lightning_instance.global_position = player.global_position
	
	get_parent().get_parent().get_parent().add_child(lightning_instance)


"""
func lightning_struck(lightning_position):
	for _i in range(3):
		var lightning_bolt_instance = lightning_bolt.instance()
		lightning_bolt_instance.target_position = lightning_position
		add_child(lightning_bolt_instance)
"""


"""
Körs av dialogic när dialogen är klar
"""

func dialog_done():
	$Music.play()
	PlayerGlobals.talking = false
	spawner1.active = true
	spawner2.active = true
	spawner3.active = true
	$AttackTimer.start()


"""
Signal för att ta skada av kulor
"""

func _on_God_body_entered(body: Node) -> void:
	if body.is_in_group("Bullet"):
		health -= body.damage_output
		body.queue_free()


func _on_AttackTimer_timeout() -> void:
	spawn_lightning()


func _on_ElevatorTimer_timeout() -> void:
	var elevator = get_node("/root/SceneController/Level3/ElevatorDoor")
	var destroyed_elevator = get_node("/root/SceneController/Level3/DestroyedElevator")
	
	elevator.queue_free()
	destroyed_elevator.visible = true

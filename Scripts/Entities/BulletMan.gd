extends KinematicBody2D

export var enemy_type: String
export var speed: int = 400
export var health: int = 250

onready var player: KinematicBody2D = get_parent().get_node("Player")

var target_position: Vector2 = Vector2.ZERO
var on_target: bool = false

var is_dead: bool = false

var ammo_pouch: Resource = load("res://Scenes/Weapons/AmmoPouch.tscn")



func _ready() -> void:
	randomize()
	generate_target_position()
	rotation = global_position.angle_to_point(target_position) + deg2rad(-90)


"""
Kollar om spelaren är död och spawnar ammo_pouch
Kollar om BulletMan är nog nära target_position och startar en timer

Om inte på målet så körs move() funktionen

"""
func _physics_process(delta: float) -> void:
	$AnimatedSprite/HealthBar.value = health
	if health <= 0 and !is_dead:
		is_dead = true
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



"""
Ansvarar för rörelsen av BulletMan
"""

func move() -> void:
	var velocity: Vector2 = Vector2.ZERO
	var direction: Vector2 = global_position.direction_to(target_position)
	velocity = direction * speed
	velocity = move_and_slide(velocity)


"""
Genererar ny target_position i en cirkle runt om spelaren
"""

func generate_target_position() -> void:
	var random: RandomNumberGenerator = RandomNumberGenerator.new()
	random.randomize()
	var angle: int = random.randi_range(0, 360)
	var radius: int = 20000
	target_position = player.global_position + Vector2(sqrt(radius) * cos(deg2rad(angle)), sqrt(radius) * sin(deg2rad(angle)))


"""
När timern går ut genereras ny position och roterar BulletMan
"""

func _on_PauseTimer_timeout() -> void:
	generate_target_position()
	on_target = false
	rotation = global_position.angle_to_point(target_position) + deg2rad(-90)


"""
Om BulletMan kolliderar med spelaren tas hp bort från spelaren och 
BulletMan exploderar.
Tar skada av granaterna.
"""

func _on_DetectionArea_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("Player"):
		# Explode
		PlayerGlobals.health -= 80
		speed = 0
		$AnimatedSprite.play("explosion")
	
	if area.get_parent().is_in_group("Grenade"):
		health -= area.get_parent().damage_output


"""
Tar skada av kulorna och sätter hp
"""

func _on_DetectionArea_body_entered(body: Node) -> void:
	if body.is_in_group("Bullet"):
		health -= body.damage_output
		body.queue_free()


"""
När explotion animationen är klar tas BulletMan bort
"""

func _on_AnimatedSprite_animation_finished() -> void:
	if $AnimatedSprite.animation == "explosion":
		Stats.bullet_man_killed += 1
		if !EnvVar.in_challenge_run:
				PlayerGlobals.coins += 2
		queue_free()

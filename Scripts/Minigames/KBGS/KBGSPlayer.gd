extends KinematicBody2D

onready var scene_controller: Node = get_node("/root/SceneController")

var health: int = 100

var walk_speed: int = 400
var gravity: int = 1500
var jump_force: int = 900

var is_punching: bool = false
var enemy: Node
var enemy_amount: int = 6


var velocity: Vector2 = Vector2.ZERO
var last_velocity: Vector2 = Vector2(-1, 0)


func _ready() -> void:
	$PlayerPunchArea/PlayerHitShape.disabled = true


"""
Uppdaterar overlay.
Kollar om spelaren är död och sätter isåfall "EnvVar.kbgs_minigame_won = false"
Om det inte finns någon ememy kvar så EnvVar.kbgs_minigame_won = true.
Därefter byts scene
"""

func _physics_process(delta: float) -> void:
	$Overlay/EnemiesLeft.text = "Enemies left: " + str(enemy_amount)
	$Overlay/ProgressBar.value = health
	if health <= 0:
		EnvVar.kbgs_minigame_won = false
		scene_controller.change_scene(false, get_parent(), get_parent().filename, "res://Scenes/Minigames/KBGS/KBGSStartMenu.tscn")
	if enemy_amount <= 0:
		EnvVar.kbgs_minigame_won = true
		scene_controller.change_scene(false, get_parent(), get_parent().filename, "res://Scenes/Minigames/KBGS/KBGSStartMenu.tscn")
	movement()


"""
Sköter spelarens rörelse.
Regulerar olika rörelser beroende på spelarens tidigare rörelser.
"""

func movement() -> void:
	
	velocity.x = 0
	velocity.y += get_physics_process_delta_time() * gravity
	
	if Input.is_action_pressed("mini_right"):
		velocity += Vector2.RIGHT
	if Input.is_action_pressed("mini_left"):
		velocity += Vector2.LEFT
	if Input.is_action_pressed("mini_jump") and is_on_floor():
		velocity.y += -jump_force
	
	if Input.is_action_pressed("mini_hit") and not is_punching:
		$PlayerPunchArea/PlayerHitShape.disabled = false
		is_punching = true
		$Punch.play()
		$AnimatedSprite.play("Hit")
	
	
	elif (velocity.x != 0 or !is_on_floor()) and not is_punching:
		
		if velocity.x != 0:
			last_velocity.x = velocity.x
		
		if last_velocity.x == -1:
			$PlayerPunchArea.scale.x = 1
			$AnimatedSprite.scale.x = 1
			if !is_on_floor():
				$AnimatedSprite.play("Jump")
			else:
				$AnimatedSprite.play("Walk")
		elif last_velocity.x == 1:
			$PlayerPunchArea.scale.x = -1
			$AnimatedSprite.scale.x = -1
			if !is_on_floor():
				$AnimatedSprite.play("Jump")
			else:
				$AnimatedSprite.play("Walk")
		
	elif velocity.x == 0 and not is_punching:
		if last_velocity.x == -1:
			$AnimatedSprite.scale.x = 1
			$AnimatedSprite.play("Idle")
		elif last_velocity.x == 1:
			$AnimatedSprite.scale.x = -1
			$AnimatedSprite.play("Idle")
	
	velocity.x = velocity.x * walk_speed
	
	velocity = move_and_slide(velocity, Vector2.UP)


"""
När animationen är körd så aktiveras "PlayerPunchArea"
"""

func _on_AnimatedSprite_animation_finished() -> void:
	if is_punching:
		$PlayerPunchArea/PlayerHitShape.disabled = true
		is_punching = false


"""
Kollar om spelaren befinner sig i "EnemySwingArea" och tar skada isåfall.
Om spelaren befinner sig på "Medkit" så bostas hp.
"""

func _on_PlayerHitbox_area_entered(area: Area2D) -> void:
	if area.name == "EnemySwingArea":
		$Hit.play()
		health -= 20
	if area.is_in_group("Medkit") and health < 100:
		$MedkitPickup.play()
		health += 40
		if health > 100:
			health = 100
		area.queue_free()


extends Node

var health: int = 100
var dead: bool = false
var has_gun: bool = true
var player_path: String = ""

var talking: bool = false

var coins: int = 0

var magazine_size: int
var bullets_in_mag: int 
var bullets_in_mag_main: int 
var bullets_left: int = 200
var bullets_left_main: int = bullets_left

var grenades_left: int = 5
var holding_grenade: bool = false

var current_weapon: String = "res://Scenes/Weapons/Pistol.tscn"

var elevator_floor_access: Array = [0, 1]


func _ready() -> void:
	magazine_size = load(current_weapon).instance().magazine_size
	bullets_in_mag = magazine_size


func _physics_process(delta: float) -> void:
	if health <= 0 and !dead:
		dead = true


# Needs to be a function for dialogic to access
func set_talking_state() -> void:
	talking = false
	EnvVar.can_pause = true
	SaveGame.save_data()


# Takes bullets as an string. Needed for dialogic
func set_weapon(weapon_path: String, bullets: String) -> void:
	var player: KinematicBody2D = get_node(player_path)
	has_gun = true
	
	var weapon = load(weapon_path)
	current_weapon = weapon_path
	weapon = weapon.instance()
	weapon.position = player.get_node("PlayerCamera").position
	weapon.bullets_in_mag = int(bullets)
	
	for node in player.get_children():
		if node.is_in_group("Weapon"):
			node.queue_free()
	player.add_child(weapon)


func dialogic_set_health(cost: String) -> void:
	health = 100
	coins =- int(cost)


func dialogic_set_ammunition(cost: String) -> void:
	bullets_left = 300
	grenades_left = 5
	coins =- int(cost)


func dialogic_get_coins() -> void:
	Dialogic.set_variable("PlayerCoins", str(coins))


func give_keycard(floor_number: int) -> void:
	if !(floor_number in elevator_floor_access):
		elevator_floor_access.append(floor_number)

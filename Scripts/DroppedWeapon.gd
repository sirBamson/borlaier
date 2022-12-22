extends Area2D


onready var weapons: Dictionary = {
	"res://Scenes/Weapons/AssultRifle.tscn": get_node("AssultRifleShape"),
	"res://Scenes/Weapons/Pistol.tscn": get_node("PistolShape")
	}

# Change for diffret drop entities
var player_current_weapon: String = PlayerGlobals.current_weapon
export var weapon_type: String = player_current_weapon


func _ready() -> void:
	var weapon: CollisionShape2D = weapons[weapon_type]
	weapon.disabled = false
	weapon.visible = true
	
	randomize()
	var random_angle = rand_range(30, -30)
	rotation_degrees = random_angle

extends Area2D


onready var weapons: Dictionary = {
	"res://Scenes/Weapons/AssultRifle.tscn": get_node("AssultRifleShape"),
	"res://Scenes/Weapons/Pistol.tscn": get_node("PistolShape")
	}

# Change for diffret drop entities
var weapon_type: String = PlayerGlobals.current_weapon


func _ready() -> void:
	weapon_type = "res://Scenes/Weapons/Pistol.tscn"
	var weapon: CollisionShape2D = weapons[weapon_type]
	weapon.disabled = false
	weapon.visible = true

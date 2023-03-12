extends Area2D


onready var weapons: Dictionary = {
	"res://Scenes/Weapons/AssultRifle.tscn": get_node("AssultRifleShape"),
	"res://Scenes/Weapons/Pistol.tscn": get_node("PistolShape"),
	"res://Scenes/Weapons/SemiAutomaticRifle.tscn": get_node("SemiAutomaticRifleShape"),
	"res://Scenes/Weapons/SMG.tscn": get_node("SMGShape"),
	"res://Scenes/Weapons/Minigun.tscn": get_node("MinigunShape")
	}


# Change for diffret drop entities
var player_current_weapon: String = PlayerGlobals.current_weapon
export var weapon_type: String = player_current_weapon

export var bullets_in_mag: int 


func _ready() -> void:
	var weapon: CollisionShape2D = weapons[weapon_type]
	weapon.disabled = false
	weapon.visible = true
	
	#randomize()
	#var random_angle = rand_range(30, -30)
	#rotation_degrees = random_angle

extends Node

var player_healt: int = 100
var player_has_gun: bool = true

var magazine_size: int
var bullets_in_mag: int 
var bullets_left: int = 200

var grenades_left: int = 2
var holding_grenade: bool = false

var current_weapon: String = "res://Scenes/Weapons/AssultRifle.tscn"

var elevator_floor_access: int = 4


func _ready() -> void:
	magazine_size = load(current_weapon).instance().magazine_size
	bullets_in_mag = magazine_size

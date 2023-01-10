extends Node

var player_healt: int = 100
var player_has_gun: bool = true

var magazine_size: int
var bullets_in_mag: int 
var bullets_left: int = 200

var current_weapon: String = "res://Scenes/Weapons/AssultRifle.tscn"


func _ready() -> void:
	magazine_size = load(current_weapon).instance().magazine_size
	bullets_in_mag = magazine_size

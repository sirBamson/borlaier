extends Node2D

var color: String = "Red"

onready var animated_sprite: AnimatedSprite = $AnimatedSprite


func _ready() -> void:
	randomize()
	animated_sprite.play(color)
	
	yield(get_tree().create_timer(randi() % 31 + 120), "timeout")
	queue_free()
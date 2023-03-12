extends Node2D

var color: String = "Red"

onready var animated_sprite: AnimatedSprite = $AnimatedSprite


"""
Sätter rätt färg på död Chipling och startar livs timer på ca 2min
"""

func _ready() -> void:
	randomize()
	animated_sprite.play(color)
	
	yield(get_tree().create_timer(randi() % 31 + 120), "timeout")
	queue_free()

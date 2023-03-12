extends Node2D
"""
Används ej nu
"""

var big_hand_path: String = "res://Scenes/Minigames/PunishingPoker/BigHand.tscn"


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("dev"):
		var big_hand = load(big_hand_path).instance()
		big_hand.global_position = get_global_mouse_position()
		add_child(big_hand)

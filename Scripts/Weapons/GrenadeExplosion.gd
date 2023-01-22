extends Area2D

var time_in_seconds = 1

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("ThrowGrenade"):
		yield(get_tree().create_timer(time_in_seconds), "timeout")
	$AnimatedSprite.play("default")

extends Node2D



func _physics_process(delta: float) -> void:
	#print(EnvVar.elevator_current_level_number)
	print(EnvVar.elevator_old_level_number)
	$ArrowDown.visible = false
	$ArrowUp.visible = false
	if EnvVar.elevator_button_number_pressed > EnvVar.elevator_old_level_number:
		$AnimatedSprite.play("FloorIndex")
		if $AnimatedSprite.frame == ((EnvVar.elevator_button_number_pressed * 11) - 1):
			$AnimatedSprite.stop()
	if EnvVar.elevator_button_number_pressed < EnvVar.elevator_old_level_number:
		$AnimatedSprite.play("FloorIndex", true)
		if $AnimatedSprite.frame == ((EnvVar.elevator_button_number_pressed * 11) - 1):
			$AnimatedSprite.stop()

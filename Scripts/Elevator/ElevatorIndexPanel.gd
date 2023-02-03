extends Node2D


func _ready() -> void:
	$AnimatedSprite.frame = (EnvVar.elevator_current_level_number * 11)
	$ArrowDown.visible = false
	$ArrowUp.visible = false


func _physics_process(delta: float) -> void:
	
	if EnvVar.elevator_old_level_number != EnvVar.elevator_oldest_level_number:
		
		if EnvVar.elevator_button_number_pressed > EnvVar.elevator_old_level_number:
			EnvVar.elevator_oldest_level_number = EnvVar.elevator_old_level_number
			$ArrowUp.visible = true
			$AnimatedSprite.frame = (EnvVar.elevator_old_level_number * 11)
			$AnimatedSprite.play("FloorIndex")
			
		if EnvVar.elevator_button_number_pressed < EnvVar.elevator_old_level_number:
			EnvVar.elevator_oldest_level_number = EnvVar.elevator_old_level_number
			$ArrowDown.visible = true
			$AnimatedSprite.frame = (EnvVar.elevator_old_level_number * 11)
			$AnimatedSprite.play("FloorIndex", true)
		
	if $AnimatedSprite.frame == (EnvVar.elevator_button_number_pressed * 11):
		$ArrowDown.visible = false
		$ArrowUp.visible = false
		$AnimatedSprite.stop()

extends Node2D

var _to: int

"""
Sätter alla pilar till false och ska sätta rätt number på index panelen i hissen.
"""

func _ready() -> void:
	$AnimatedSprite.frame = EnvVar.elevator_current_level_number * 11
	$ArrowDown.visible = false
	$ArrowUp.visible = false


"""
Beroende på om hissen körs upp eller ner så sätts pilen i hissen till olika håll.
Sätter även vilket number som ska visas av AnimatedSprite.
"""
"""
func _physics_process(_delta: float) -> void:
	
	if EnvVar.elevator_old_level_number != EnvVar.elevator_oldest_level_number:
		
		if EnvVar.elevator_current_level_number > EnvVar.elevator_old_level_number:
			EnvVar.elevator_oldest_level_number = EnvVar.elevator_old_level_number
			$ArrowUp.visible = true
			$AnimatedSprite.frame = (EnvVar.elevator_old_level_number * 11)
			$AnimatedSprite.play("FloorIndex")
			
		if EnvVar.elevator_current_level_number < EnvVar.elevator_old_level_number:
			EnvVar.elevator_oldest_level_number = EnvVar.elevator_old_level_number
			$ArrowDown.visible = true
			$AnimatedSprite.frame = (EnvVar.elevator_old_level_number * 11)
			$AnimatedSprite.play("FloorIndex", true)
		
	if $AnimatedSprite.frame == (EnvVar.elevator_button_number_pressed * 11):
		$ArrowDown.visible = false
		$ArrowUp.visible = false
		$AnimatedSprite.stop()
"""


func set_index(to: int, from: int):
	_to = to
	
	$AnimatedSprite.frame = from * 10
	
	if from < to:
		# Going up!
		$ArrowDown.visible = false
		$ArrowUp.visible = true
		
		$AnimatedSprite.play("FloorIndex")
	elif from > to:
		# Going down!
		$ArrowDown.visible = true
		$ArrowUp.visible = false
		
		$AnimatedSprite.play("FloorIndex", true)



func _on_AnimatedSprite_frame_changed() -> void:
	if $AnimatedSprite.frame == _to * 10:
		$AnimatedSprite.stop()
		$ArrowDown.visible = false
		$ArrowUp.visible = false

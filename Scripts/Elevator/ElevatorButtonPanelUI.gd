extends CanvasLayer

var active: bool = false

"""
Alla funktioner sätter vilken knapp som pressas.
Används av knappanelen.
"""

func _ready() -> void:
	visible = false


func _on_0_pressed() -> void:
	print("HERE")
	EnvVar.elevator_button_number_pressed = 0


func _on_1_button_up() -> void:
	EnvVar.elevator_button_number_pressed = 1


func _on_2_button_up() -> void:
	EnvVar.elevator_button_number_pressed = 2


func _on_3_button_up() -> void:
	EnvVar.elevator_button_number_pressed = 3


func _on_4_button_up() -> void:
	EnvVar.elevator_button_number_pressed = 4


func enterd_elevator_ui() -> void:
	EnvVar.elevator_button_number_pressed = EnvVar.elevator_current_level_number
	active = true
	get_tree().paused = true
	EnvVar.can_pause = false
	visible = true


func exited_elevator_ui() -> void:
	active = false
	get_tree().paused = false
	EnvVar.can_pause = true
	visible = false

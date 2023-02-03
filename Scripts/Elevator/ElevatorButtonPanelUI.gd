extends CanvasLayer


func _ready() -> void:
	$UI/Floor.text = "Floor: " + str(EnvVar.elevator_current_level_number)
	visible = false


func _on_0_pressed() -> void:
	EnvVar.elevator_button_number_pressed = 0
	$UI/Floor.text = "Floor: " + str(EnvVar.elevator_button_number_pressed)


func _on_1_button_up() -> void:
	EnvVar.elevator_button_number_pressed = 1
	$UI/Floor.text = "Floor: " + str(EnvVar.elevator_button_number_pressed)


func _on_2_button_up() -> void:
	EnvVar.elevator_button_number_pressed = 2
	$UI/Floor.text = "Floor: " + str(EnvVar.elevator_button_number_pressed)


func _on_3_button_up() -> void:
	EnvVar.elevator_button_number_pressed = 3
	$UI/Floor.text = "Floor: " + str(EnvVar.elevator_button_number_pressed)


func _on_4_button_up() -> void:
	EnvVar.elevator_button_number_pressed = 4
	$UI/Floor.text = "Floor: " + str(EnvVar.elevator_button_number_pressed)

extends CanvasLayer



func _ready() -> void:
	$UI/Floor.text = "Floor " + str(EnvVar.current_level_number)
	visible = false


func _on_0_pressed() -> void:
	if EnvVar.current_level_number != 0:
		Dialogic.set_variable("FloorNumber", 0)
		EnvVar.current_level_number = 0
		$UI/Floor.text = "Floor 0"
		EnvVar.next_level = "res://Scenes/Levels/Level0.tscn"


func _on_1_button_up() -> void:
	if EnvVar.current_level_number != 1:
		Dialogic.set_variable("FloorNumber", 1)
		EnvVar.current_level_number = 1
		$UI/Floor.text = "Floor 1"
		EnvVar.next_level = "res://Scenes/Levels/Level1.tscn"


func _on_2_button_up() -> void:
	if EnvVar.current_level_number != 2:
		Dialogic.set_variable("FloorNumber", 2)
		EnvVar.current_level_number = 2
		$UI/Floor.text = "Floor 2"
		EnvVar.next_level = "res://Scenes/Levels/Level2.tscn"


func _on_3_button_up() -> void:
	if EnvVar.current_level_number != 3:
		Dialogic.set_variable("FloorNumber", 3)
		EnvVar.current_level_number = 3
		$UI/Floor.text = "Floor 3"


func _on_4_button_up() -> void:
	if EnvVar.current_level_number != 4:
		Dialogic.set_variable("FloorNumber", 4)
		EnvVar.current_level_number = 4
		$UI/Floor.text = "Floor 4"

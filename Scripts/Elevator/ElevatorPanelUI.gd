extends CanvasLayer


var current_floor: int = EnvVar.current_level_number


func _ready() -> void:
	$UI/Floor.text = "Floor " + str(current_floor)
	visible = false


func _on_0_pressed() -> void:
	if current_floor != 0:
		current_floor = 0
		EnvVar.current_level_number = 0
		$UI/Floor.text = "Floor 0"
		EnvVar.next_level = "res://Scenes/Levels/LevelLobby.tscn"


func _on_1_button_up() -> void:
	if current_floor != 1:
		current_floor = 1
		EnvVar.current_level_number = 1
		$UI/Floor.text = "Floor 1"
		EnvVar.next_level = "res://Scenes/Levels/Level1.tscn"


func _on_2_button_up() -> void:
	if current_floor != 2:
		current_floor = 2
		EnvVar.current_level_number = 2
		$UI/Floor.text = "Floor 2"
		EnvVar.next_level = "res://Scenes/Levels/Level2.tscn"


func _on_3_button_up() -> void:
	if current_floor != 3:
		current_floor = 3
		EnvVar.current_level_number = 3
		$UI/Floor.text = "Floor 3"


func _on_4_button_up() -> void:
	if current_floor != 4:
		current_floor = 4
		EnvVar.current_level_number = 4
		$UI/Floor.text = "Floor 4"

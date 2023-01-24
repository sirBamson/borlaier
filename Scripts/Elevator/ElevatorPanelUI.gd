extends CanvasLayer


var next_floor: int = EnvVar.current_level_number
var available_levels: Dictionary = {
	0: "res://Scenes/Levels/Level0.tscn",
	1: "res://Scenes/Levels/Level1.tscn",
	2: "res://Scenes/Levels/Level2.tscn"
}


func _ready() -> void:
	$UI/Floor.text = "Floor: " + str(EnvVar.current_level_number)
	visible = false


func _physics_process(_delta: float) -> void:
	if next_floor in available_levels:
		if next_floor != EnvVar.current_level_number:
			if next_floor <= PlayerGlobals.elevator_floor_access:
				EnvVar.current_level_number = next_floor
				Dialogic.set_variable("ElevatorFloorNumber", next_floor)
				$UI/Floor.text = "Floor: " + str(next_floor)
				EnvVar.next_level = available_levels.get(next_floor)
			elif next_floor > PlayerGlobals.elevator_floor_access:
				Dialogic.set_variable("ElevatorFloorAccess", false)


func _on_0_pressed() -> void:
	next_floor = 0


func _on_1_button_up() -> void:
	next_floor = 1


func _on_2_button_up() -> void:
	next_floor = 2


func _on_3_button_up() -> void:
	next_floor = 3


func _on_4_button_up() -> void:
	next_floor = 4

extends CanvasLayer

var new_level: bool = false
var new_level_access: bool = false
var next_floor: int = EnvVar.current_level_number
var available_levels: Dictionary = {
	0: "res://Scenes/Levels/Level0.tscn",
	1: "res://Scenes/Levels/Level1.tscn",
	2: "res://Scenes/Levels/Level2.tscn",
	3: "res://Scenes/Levels/Level2.tscn"
}


func _ready() -> void:
	$UI/Floor.text = "Floor: " + str(EnvVar.current_level_number)
	visible = false


func _physics_process(_delta: float) -> void:
	if next_floor in available_levels:
		if next_floor != EnvVar.current_level_number:
			$UI/Floor.text = "Floor: " + str(next_floor)
			new_level = true
			if next_floor in PlayerGlobals.elevator_floor_access:
				EnvVar.current_level_number = next_floor
				EnvVar.next_level = available_levels.get(next_floor)
				Dialogic.set_variable("ElevatorFloorNumber", next_floor)
				new_level_access = true
			else:
				
				new_level_access = false


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

extends Node


var first_time_played: bool = true
var in_challenge_run: bool = false


# A string that is set to the current or latest level / floor
var latest_level_path: String = "res://Scenes/Levels/Level0.tscn"

# Path to the node that loads the minigame
var minigame_load_scene_path: String = ""
var kbgs_minigame_first_time: bool = true
var kbgs_minigame_won: bool = false


var available_levels: Dictionary = {
	0: "res://Scenes/Levels/Level0.tscn",
	1: "res://Scenes/Levels/Level1.tscn",
	2: "res://Scenes/Levels/Level2.tscn",
	3: "res://Scenes/Levels/Level3.tscn"
	}


# Shows which is the next scene in elevator
var elevator_next_level: String = latest_level_path
var elevator_current_level_number: int = 0
var elevator_old_level_number: int = -1
var elevator_oldest_level_number: int = -2
var elevator_button_number_pressed: int
var elevator_moving: bool = false

var can_pause: bool = false


func _ready() -> void:
	Dialogic.set_variable("ElevatorFloorNumber", elevator_current_level_number)

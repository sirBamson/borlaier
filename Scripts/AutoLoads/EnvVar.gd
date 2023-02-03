extends Node

# A dictionary with the various saved scenes in PackedScene format
var saved_scenes: Dictionary = {}
# A dictionary that contains the different file paths
var saved_scenes_strings: Dictionary = {}

# Path to the node that loads the minigame
var minigame_load_scene_path: String = ""
var kbgs_minigame_first_time: bool = true
var kbgs_minigame_won: bool = false

# Shows which is the next scene in elevator
var elevator_next_level: String = "res://Scenes/Levels/Level0.tscn"
var elevator_current_level_number: int = 0
var elevator_old_level_number: int = 0
var elevator_oldest_level_number: int = -1
var elevator_button_number_pressed: int = 0
var elevator_moving: bool = false

var can_pause: bool = false


func _ready() -> void:
	Dialogic.set_variable("ElevatorFloorNumber", elevator_current_level_number)

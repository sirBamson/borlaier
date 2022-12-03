extends Node

# A dictionary with the various saved scenes in PackedScene format
var saved_scenes: Dictionary = {}
# A dictionary that contains the different file paths
var saved_scenes_strings: Dictionary = {}
var current_level_number: int = 0

# Shows which is the next scene
var next_level: String = "res://Scenes/Levels/LevelLobby.tscn"
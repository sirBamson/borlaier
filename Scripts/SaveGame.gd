extends Node


const SAVE_FILE: String = "res://DEBUG/borlaier_game.save"
const SAVE_FILE_DIR: String = "res://DEBUG"
# Use user://borlaier_game.save

var game_data: Dictionary = {}


func _ready() -> void:
	load_data()
	print(game_data["player_bullets_left"])



func save_data() -> void:
	get_game_data()
	var dir: Directory = Directory.new()
	if not dir.dir_exists(SAVE_FILE_DIR):
		dir.make_dir(SAVE_FILE_DIR)
	
	var file: File = File.new()
	file.open(SAVE_FILE, File.WRITE)
	file.store_var(game_data)
	file.close()
	print("Game data saved")


func load_data() -> void:
	var file: File = File.new()
	if not file.file_exists(SAVE_FILE):
		save_data()
	file.open(SAVE_FILE, File.READ)
	game_data = file.get_var()
	file.close()
	set_game_data()


func reset_data() -> void:
	var dir: Directory = Directory.new()
	if dir.file_exists(SAVE_FILE):
		dir.remove(SAVE_FILE)
	else:
		print("Can't delet file. Doesn't exist!")


func get_game_data() -> void:
	game_data = {
		# Player data
		"player_health": PlayerGlobals.health,
		"player_has_gun": PlayerGlobals.has_gun,
		"player_talking": PlayerGlobals.talking,
		"player_coins": PlayerGlobals.coins,
		"player_magazine_size": PlayerGlobals.magazine_size,
		"player_bullets_in_mag": PlayerGlobals.bullets_in_mag,
		"player_bullets_left": PlayerGlobals.bullets_left,
		"player_grenades_left": PlayerGlobals.grenades_left,
		"player_holding_grenade": PlayerGlobals.holding_grenade,
		"player_current_weapon": PlayerGlobals.current_weapon,
		"player_elevator_floor_access": PlayerGlobals.elevator_floor_access,
		
		# EnvVar data
		"EnvVar_first_time_played": EnvVar.first_time_played,
		"EnvVar_saved_scenes": EnvVar.saved_scenes,
		"EnvVar_saved_scenes_strings": EnvVar.saved_scenes_strings,
		"EnvVar_latest_level_path": EnvVar.latest_level_path,
		"EnvVar_minigame_load_scene_path": EnvVar.minigame_load_scene_path,
		"EnvVar_kbgs_minigame_first_time": EnvVar.kbgs_minigame_first_time,
		"EnvVar_kbgs_minigame_won": EnvVar.kbgs_minigame_won,
		"EnvVar_elevator_next_level": EnvVar.elevator_next_level,
		"EnvVar_elevator_current_level_number": EnvVar.elevator_current_level_number,
		"EnvVar_elevator_old_level_number": EnvVar.elevator_old_level_number,
		"EnvVar_elevator_oldest_level_number": EnvVar.elevator_next_level,
		"EnvVar_elevator_button_number_pressed": EnvVar.elevator_button_number_pressed,
		"EnvVar_elevator_moving": EnvVar.elevator_moving,

	}


func set_game_data() -> void:
	PlayerGlobals.health = game_data["player_health"]
	PlayerGlobals.has_gun = game_data["player_has_gun"]
	PlayerGlobals.talking = game_data["player_talking"]
	PlayerGlobals.coins = game_data["player_coins"]
	PlayerGlobals.magazine_size = game_data["player_magazine_size"]
	PlayerGlobals.bullets_in_mag = game_data["player_bullets_in_mag"]
	PlayerGlobals.bullets_left = game_data["player_bullets_left"]
	PlayerGlobals.grenades_left = game_data["player_grenades_left"]
	PlayerGlobals.holding_grenade = game_data["player_holding_grenade"]
	PlayerGlobals.current_weapon = game_data["player_current_weapon"]
	PlayerGlobals.elevator_floor_access = game_data["player_elevator_floor_access"]
	
	EnvVar.first_time_played = game_data["EnvVar_first_time_played"]
	EnvVar.saved_scenes = game_data["EnvVar_saved_scenes"]
	EnvVar.saved_scenes_strings = game_data["EnvVar_saved_scenes_strings"]
	EnvVar.latest_level_path = game_data["EnvVar_latest_level_path"]
	EnvVar.minigame_load_scene_path = game_data["EnvVar_minigame_load_scene_path"]
	EnvVar.kbgs_minigame_first_time = game_data["EnvVar_kbgs_minigame_first_time"]
	EnvVar.kbgs_minigame_won = game_data["EnvVar_kbgs_minigame_won"]
	EnvVar.elevator_next_level = game_data["EnvVar_elevator_next_level"]
	EnvVar.elevator_current_level_number = game_data["EnvVar_elevator_current_level_number"]
	EnvVar.elevator_old_level_number = game_data["EnvVar_elevator_old_level_number"]
	EnvVar.elevator_oldest_level_number = game_data["EnvVar_elevator_oldest_level_number"]
	EnvVar.elevator_button_number_pressed = game_data["EnvVar_elevator_button_number_pressed"]
	EnvVar.elevator_moving = game_data["EnvVar_elevator_moving"]

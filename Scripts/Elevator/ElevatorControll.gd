extends Area2D

signal change_scene(save_current_scene, current_scene, current_scene_path, new_scene_path)


var changing_scene: bool = false
var can_use_door: bool = false
var door_animation: String = "LevelDoor"
var new_level_path: String = EnvVar.next_level


func _ready() -> void:
	# Sets which animation to play
	# Can choose between: ElevatorDoor, "LevelDoor"
	if get_parent().is_in_group("Elevator"):
		door_animation = "ElevatorDoor"
	
	var _err = connect("change_scene", get_node("/root/SceneController"), "change_scene")
	# Add player to scene
	$Door.play(door_animation, true)


func emit_signal_change_scene() -> void:
	var current_scene: Node = get_parent()
	var current_scene_path: String
	
	# The Filename property cannot see the file path from a PackedScene
	# Therefore, a dictionary is needed with the various saved file paths
	if current_scene.name in EnvVar.saved_scenes_strings:
		current_scene_path = EnvVar.saved_scenes_strings[current_scene.name]
	else:
		current_scene_path = current_scene.filename
	
	
	# Checks which group current_scene belongs to
	# Then calls the change_scene signal
	if current_scene.is_in_group("Level"):
		emit_signal("change_scene", true, current_scene, current_scene_path, "res://Scenes/Elevator/Elevator.tscn")
	elif current_scene.is_in_group("Elevator"):
		emit_signal("change_scene", false, current_scene, current_scene_path, EnvVar.next_level)


func _physics_process(_delta: float) -> void:
	if can_use_door:
		if Input.is_action_pressed("ui_accept"):
			changing_scene = true
			# Play door animation
			$Door.play(door_animation)


# Checks if the player is in the designated area
func _on_ElevatorDoor_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		can_use_door = true

func _on_ElevatorDoor_body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		can_use_door = false


# Runs when the door animation is finished and changing_scene == true
# Must have a check otherwise it would run when opened and closed
func _on_AnimatedSprite_animation_finished() -> void:
	if changing_scene:
		emit_signal_change_scene()

extends Area2D

signal change_scene(save_current_scene, current_scene, current_scene_path, new_scene_path)


var changing_scene: bool = false
var can_use_door: bool = false
var new_level: bool = false
var new_level_path: String


func _ready() -> void:
	var _err = connect("change_scene", get_node("/root/SceneController"), "change_scene")
	# Add player to scene
	$OutsideDoor.play("default", true)


func _on_ElevatorDoor_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		can_use_door = true

func _on_ElevatorDoor_body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		can_use_door = false


func _on_AnimatedSprite_animation_finished() -> void:
	
	if changing_scene:
		emit_signal_change_scene()


func _on_ElevatorPanelUI_new_floor(scene_path) -> void:
	new_level = true
	new_level_path = scene_path



func _physics_process(_delta: float) -> void:
	if can_use_door:
		if Input.is_action_pressed("ui_accept"):
			changing_scene = true
			# Play door animation
			$OutsideDoor.play("default")


func emit_signal_change_scene() -> void:
	var current_scene: Node = get_parent()
	var current_scene_path: String = current_scene.filename
	
	
	#Check if scene is the elevator
	if current_scene.is_in_group("Level"):
		emit_signal("change_scene", true, current_scene, current_scene_path, "res://Scenes/Elevator/Elevator.tscn")
	elif current_scene.is_in_group("Elevator"):
		if !new_level:
			emit_signal("change_scene", false, current_scene, current_scene_path, "return")
		else:
			emit_signal("change_scene", false, current_scene, current_scene_path, new_level_path)

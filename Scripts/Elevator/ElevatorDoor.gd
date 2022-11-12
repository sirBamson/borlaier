extends Area2D

signal change_scene(current_scene, new_scene_path)


var changing_scene: bool = false
var in_elevator_door: bool = false
var change_to_scene_path: String = ""


func _ready() -> void:
	connect("change_scene", get_node("/root/SceneController"), "change_to_scene")
	# Add player to scene
	$AnimatedSprite.play("default", true)


func _physics_process(_delta: float) -> void:
	if in_elevator_door:
		if Input.is_action_pressed("ui_accept"):
			changing_scene = true
			# Play door animation
			$AnimatedSprite.play("default")


func _on_ElevatorDoor_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		in_elevator_door = true

func _on_ElevatorDoor_body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		in_elevator_door = false


func _on_AnimatedSprite_animation_finished() -> void:
	if changing_scene:
		var current_scene = get_parent()
		
		if current_scene.is_in_group("Level"):
			emit_signal("change_scene", current_scene, false, "res://Scenes/Elevator/Elevator.tscn")
		elif current_scene.is_in_group("Elevator"):
			# If player exits the elevator emit this
			emit_signal("change_scene", current_scene, true, "")


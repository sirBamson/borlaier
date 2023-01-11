extends KinematicBody2D


onready var pathfinding = get_parent().get_parent().get_node("Pathfinding")
onready var player = get_parent().get_node("Player")

export (int) var speed: int = 250

var path: Array


func _physics_process(delta: float) -> void:
	movment()


func movment() -> void:
	path = pathfinding.get_new_path(global_position, player.global_position)
	print(path)
	if path.size() > 2:
		global_position = global_position.move_toward(path[1], get_process_delta_time() * speed)

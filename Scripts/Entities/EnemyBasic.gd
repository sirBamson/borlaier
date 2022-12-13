extends KinematicBody2D


export (int) var speed: int = 100

var path: Array
onready var pathfinding = get_parent().get_parent().get_node("Pathfinding")
onready var player = get_parent().get_node("Player")



func _physics_process(delta: float) -> void:
	movment()


func movment() -> void:
	path = pathfinding.get_new_path(global_position, player.global_position)
	if path.size() > 1:
		print("Next pos: " + str(path[0]))
		print("Global pos: " + str(global_position))

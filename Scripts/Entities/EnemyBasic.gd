extends KinematicBody2D


onready var pathfinding = get_parent().get_parent().get_node("Pathfinding")
onready var player = get_parent().get_node("Player")

export (int) var speed: int = 100

var path: Array


func _ready() -> void:
	path = pathfinding.get_new_path(global_position, player.global_position)


func _physics_process(delta: float) -> void:
	#draw_path()
	movment()


func movment() -> void:
	path = pathfinding.get_new_path(global_position, player.global_position)
	if path.size() > 1:
		global_position = global_position.move_toward(path[0], get_process_delta_time() * speed)


func draw_path() -> void:
	$Line2D.clear_points()
	for point in path:
		$Line2D.add_point(point)
	

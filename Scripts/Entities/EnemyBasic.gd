extends KinematicBody2D


onready var pathfinding = get_parent().get_parent().get_node("Pathfinding")
onready var player = get_parent().get_node("Player")

export (int) var speed: int = 100

var path: Array



func _physics_process(delta: float) -> void:
	movment()


func movment() -> void:
	path = pathfinding.get_new_path(global_position, player.global_position)
	
	
	var velocity: Vector2 = Vector2.ZERO
	
	if path.size() > 1:
		if global_position == path[path.size() - 1]:
			path.pop_back()
		
		velocity = velocity.direction_to(path[path.size() - 1])
		
		velocity = velocity * speed
		velocity = move_and_slide(velocity)

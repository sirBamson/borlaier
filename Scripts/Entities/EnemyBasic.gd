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
		
		var velocity: Vector2 = Vector2.ZERO
		var next_point: Vector2 = path[0]

		
		velocity = global_position.direction_to(next_point)
		print("Direction to: " + str(global_position.direction_to(next_point)))
		
		velocity = velocity.normalized() * speed
		print("Velocity: " + str(velocity))
		velocity = move_and_slide(velocity)

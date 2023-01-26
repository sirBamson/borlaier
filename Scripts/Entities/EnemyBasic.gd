extends KinematicBody2D


onready var pathfinding = get_parent().get_parent().get_node("Pathfinding")
onready var player: KinematicBody2D = get_parent().get_node("Player")

export (int) var speed: int = 250

var path: Array
var last_path: Array


func _physics_process(_delta: float) -> void:
	detect_player()
	move_towards()


func detect_player() -> void:
	$RayCast.cast_to = player.position
	print($RayCast)


func move_towards() -> void:
	var velocity: Vector2 = Vector2.ZERO
	path = pathfinding.get_new_path(global_position, player.global_position)
	if path.size() > 2:
		velocity = global_position.direction_to(path[1])
		
		velocity = velocity.normalized() * speed
		velocity = move_and_slide(velocity)

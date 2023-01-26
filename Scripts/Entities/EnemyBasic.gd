extends KinematicBody2D


onready var pathfinding = get_parent().get_parent().get_node("Pathfinding")
onready var player: KinematicBody2D = get_parent().get_node("Player")

export (int) var speed: int = 250

var path: Array
var ai_state: String = "idle"


func _physics_process(_delta: float) -> void:
	detect_player()
	hunt_player()


func detect_player() -> void:
	$RayCast.force_raycast_update()
	$RayCast.add_exception($DamageArea)
	$RayCast.cast_to = player.get_node("PlayerCamera").global_position - global_position
	
	if $RayCast.get_collider() == player:
		ai_state = "hunt"


func hunt_player() -> void:
	var velocity: Vector2 = Vector2.ZERO
	path = pathfinding.get_new_path(global_position, player.global_position)
	if path.size() > 2:
		velocity = global_position.direction_to(path[1])
		
		velocity = velocity.normalized() * speed
		velocity = move_and_slide(velocity)


func idle() -> void:
	pass

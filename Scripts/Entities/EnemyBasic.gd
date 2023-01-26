extends KinematicBody2D


onready var pathfinding = get_parent().get_parent().get_node("Pathfinding")
onready var player: KinematicBody2D = get_parent().get_node("Player")

export (int) var speed: int = 250

var path: Array
var new_position: Vector2
var ai_state: String = "hunt"


func _physics_process(_delta: float) -> void:
	detect_player()
	
	if ai_state == "idle":
		idle()
	if ai_state == "hunt":
		hunt()


func detect_player() -> void:
	$RayCast1.add_exception($DamageArea)
	$RayCast1.add_exception(player)
	$RayCast2.add_exception($DamageArea)
	$RayCast2.add_exception(player)
	$RayCast1.cast_to = player.get_node("PlayerCamera").global_position - global_position
	$RayCast2.cast_to = player.get_node("CollisionShape").global_position - global_position
	
	print($RayCast2.get_collider())
	if $RayCast1.get_collider() == player.get_node("PlayerHitbox") or $RayCast2.get_collider() == player.get_node("PlayerHitbox"):
		$IdleTimer.stop()
		ai_state = "hunt"
	elif ai_state == "hunt":
		#$IdleTimer.start(0.5)
		ai_state = "wait"


func hunt() -> void:
	var velocity: Vector2 = Vector2.ZERO
	path = pathfinding.get_new_path(global_position, player.global_position)
	if path.size() > 2:
		velocity = global_position.direction_to(path[1])
		
		velocity = velocity.normalized() * speed
		velocity = move_and_slide(velocity)


func idle() -> void:
	randomize()
	
	if global_position == new_position:
		new_position = Vector2(global_position.x + randi()% 401, global_position.y + randi()% 401)
	
	var velocity: Vector2 = Vector2.ZERO
	
	
	velocity = global_position.direction_to(new_position)
		
	velocity = velocity.normalized() * speed
	velocity = move_and_slide(velocity)


func _on_IdleTimer_timeout() -> void:
	ai_state = "idle"

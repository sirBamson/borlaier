extends KinematicBody2D


onready var pathfinding = get_parent().get_parent().get_parent().get_node("Pathfinding")
onready var player: KinematicBody2D = get_parent().get_parent().get_node("Player")

var speed: int = 250
var healt: int = 100


var path: Array
var new_position: Vector2
var ai_state: String = "hunt"


func _physics_process(_delta: float) -> void:
	if healt <= 0:
		queue_free()
	
	
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
	$RayCast1.cast_to = player.get_node("EnemyDetectionNode1").global_position - global_position
	$RayCast2.cast_to = player.get_node("EnemyDetectionNode2").global_position - global_position
	
	if $RayCast1.cast_to.x <= 0:
		$Sprite.scale.x = -0.5
	elif $RayCast1.cast_to.x > 0:
		$Sprite.scale.x = 0.5
	
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


func _on_DamageArea_body_entered(body: Node) -> void:
	if body.is_in_group("Bullet"):
		print(body.damage_output)
		healt -= body.damage_output
		body.queue_free()

extends Position2D

export (String) var enemy_path: String
export (String) var enemy_name: String
export (int) var spawn_interval: int
export (int) var max_enemy_amount: int
export (bool) var active: bool

onready var enemy: = load(enemy_path)

var enemy_amount: int

func _ready() -> void:
	$SpawnTimer.start(spawn_interval)


func _on_SpawnTimer_timeout() -> void:
	enemy_amount = 0
	for node in get_parent().get_children():
		if node.is_in_group(enemy_name):
			enemy_amount += 1
	if (enemy_amount < max_enemy_amount or max_enemy_amount == -1) and active:
		var enemy_instance = enemy.instance()
		enemy_instance.global_position = global_position
		get_parent().add_child(enemy_instance)
	

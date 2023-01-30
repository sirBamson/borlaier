extends Position2D

export (String) var enemy_path: String
export (int) var spawn_interval: int
export (int) var max_enemy_amount: int

onready var enemy: = load(enemy_path)

var enemy_amount: int = 0


func _ready() -> void:
	$SpawnTimer.start(spawn_interval)


func _on_SpawnTimer_timeout() -> void:
	enemy_amount = get_children().size()
	if !(enemy_amount >= max_enemy_amount):
		var enemy_instance = enemy.instance()
		add_child(enemy_instance)

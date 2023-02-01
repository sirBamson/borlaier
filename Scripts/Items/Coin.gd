extends Node2D


var stack_amount: int = 1




func _on_DespawnTimer_timeout() -> void:
	queue_free()

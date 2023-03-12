extends Node2D

"""
signal lightning_struck(lightning_position)

onready var god: Area2D = get_parent().get_node("Navigation2D/YSort/God")

func _ready() -> void:
	print(god)
	connect("lightning_struck", god, "lightning_struck")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	emit_signal("lightning_struck", global_position)
	yield(get_tree().create_timer(1),"timeout")
	queue_free()
"""

"""
Kör explotion när attacken är klar
"""

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	$AnimatedSprite.visible = true
	$AnimatedSprite.play("default")


func _on_AnimatedSprite_animation_finished() -> void:
	queue_free()

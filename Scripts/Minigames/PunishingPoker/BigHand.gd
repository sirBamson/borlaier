extends StaticBody2D
"""
Används ej nu
"""

func _ready() -> void:
	$AnimatedSprite.play("Slam")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	queue_free()


func _on_AnimatedSprite_animation_finished() -> void:
	$AnimatedSprite.stop()
	$AnimationPlayer.play("Shake")

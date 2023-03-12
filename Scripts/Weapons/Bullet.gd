extends RigidBody2D


"""
Kollar om kulan träffar något och tas bor då, ev. om kulan inte träfar något på ett visst tag så tas den bort.
"""

var damage_output: int


func _on_Bullet_body_entered(body: Node) -> void:
	queue_free()


func _on_LifeTimer_timeout() -> void:
	queue_free()

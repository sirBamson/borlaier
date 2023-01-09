extends Area2D



func _ready() -> void:
	visible = false
	rotation_degrees = get_parent().rotation_degrees



func _on_GunPickupPopup_area_entered(area: Area2D) -> void:
	if area.name == "PlayerHitbox":
		visible = true


func _on_GunPickupPopup_area_exited(area: Area2D) -> void:
	if area.name == "PlayerHitbox":
		visible = false

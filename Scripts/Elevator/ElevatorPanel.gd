extends Area2D
# Used to open ElevatorPanelUI

# If player can use the panel
var can_use_panel: bool = false


func _on_ElevatorPanel_body_entered(body: Node) -> void:
	print(body)
	if body.is_in_group("Player"):
		can_use_panel = true

func _on_ElevatorPanel_body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		can_use_panel = false


func _physics_process(_delta: float) -> void:
	if can_use_panel:
		if Input.is_action_pressed("ui_accept"):
			get_parent().get_node("ElevatorPanelUI").visible = true
			get_tree().paused = true
		if Input.is_action_pressed("ui_cancel"):
			get_parent().get_node("ElevatorPanelUI").visible = false
			get_tree().paused = false

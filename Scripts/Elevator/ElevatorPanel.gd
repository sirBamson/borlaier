extends Area2D
# Used to open ElevatorPanelUI

# If player can use the panel
var panel_current: bool = false
var animation_done: bool = false



func _physics_process(_delta: float) -> void:
	for area in get_overlapping_areas():
		if area.name == "PlayerHitbox":
			# Not currently using the panel
			if Input.is_action_pressed("interaction") and not panel_current and not get_tree().paused:
				panel_current = true
				get_parent().get_node("ElevatorPanelUI").visible = true
				get_tree().paused = true
				
				EnvVar.can_pause = false
			
			# Currently using the panel
			if Input.is_action_pressed("ui_cancel") and panel_current:
				panel_current = false
				get_parent().get_node("ElevatorPanelUI").visible = false
				get_tree().paused = false
				
				EnvVar.can_pause = true
				
				add_child(Dialogic.start("Elevator"))

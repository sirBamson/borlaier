extends Area2D
# Used to open ElevatorPanelUI

# If player can use the panel
var can_use_panel: bool = false
var panel_current: bool = false
var animation_done: bool = false



# Checks if the player is in the designated area
func _on_ElevatorPanel_area_entered(area: Area2D) -> void:
	if area.name == "PlayerHitbox":
		can_use_panel = true

func _on_ElevatorPanel_area_exited(area: Area2D) -> void:
	if area.name == "PlayerHitbox":
		can_use_panel = false


func _physics_process(_delta: float) -> void:
	if can_use_panel:
		
		# Not currently using the panel
		if Input.is_action_pressed("ui_accept") and not panel_current and not get_tree().paused:
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

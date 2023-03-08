extends Area2D
# Used to open ElevatorPanelUI

# If player can use the panel
var panel_current: bool = false
var animation_done: bool = false

var in_interaction_area: bool = false

var elevator_moving: bool = false

var is_new_level: bool = false
var can_access_new_level: bool = false


func _physics_process(_delta: float) -> void:
	if in_interaction_area:
		
		# Not currently using the panel
		if Input.is_action_pressed("interaction") and not panel_current and not get_tree().paused and not EnvVar.elevator_moving:
			panel_current = true
			get_parent().get_node("ElevatorPanelUI").visible = true
			get_tree().paused = true
			
			is_new_level = false
			
			EnvVar.can_pause = false
		
		# Currently using the panel
		if Input.is_action_pressed("ui_cancel") and panel_current:
			panel_current = false
			get_parent().get_node("ElevatorPanelUI").visible = false
			get_tree().paused = false
			
			EnvVar.can_pause = true
			
			
			if EnvVar.elevator_button_number_pressed in EnvVar.available_levels:
				if not EnvVar.elevator_button_number_pressed == EnvVar.elevator_current_level_number:
					is_new_level = true
					if EnvVar.elevator_button_number_pressed in PlayerGlobals.elevator_floor_access:
						can_access_new_level = true
						Dialogic.set_variable("ElevatorFloorAccess", 1)
						
						EnvVar.elevator_old_level_number = EnvVar.elevator_current_level_number
						
						EnvVar.elevator_current_level_number = EnvVar.elevator_button_number_pressed
						EnvVar.elevator_next_level = EnvVar.available_levels.get(EnvVar.elevator_button_number_pressed)
						Dialogic.set_variable("ElevatorFloorNumber", EnvVar.elevator_button_number_pressed)
						
					elif not EnvVar.elevator_button_number_pressed in PlayerGlobals.elevator_floor_access:
						can_access_new_level = false
						Dialogic.set_variable("ElevatorFloorAccess", 0)
				
				elif EnvVar.elevator_button_number_pressed == EnvVar.elevator_current_level_number:
					is_new_level = false
			
			
			if is_new_level:
				if can_access_new_level:
					get_parent().get_node("WaitTimer").start(abs(EnvVar.elevator_old_level_number - EnvVar.elevator_button_number_pressed))
					EnvVar.elevator_moving = true
				elif not can_access_new_level:
					add_child(Dialogic.start("ElevatorFloorNumber"))
					get_parent().get_node("WaitTimer").start(4)
					EnvVar.elevator_moving = true





func _on_ElevatorPanel_area_entered(area: Area2D) -> void:
	if area.name == "PlayerHitbox":
		in_interaction_area = true

func _on_ElevatorPanel_area_exited(area: Area2D) -> void:
	if area.name == "PlayerHitbox":
		in_interaction_area = false


func _on_WaitTimer_timeout() -> void:
	add_child(Dialogic.start("ElevatorFloorNumber"))
	EnvVar.elevator_moving = false
	is_new_level = false

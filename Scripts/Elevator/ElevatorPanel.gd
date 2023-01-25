extends Area2D
# Used to open ElevatorPanelUI

# If player can use the panel
var panel_current: bool = false
var animation_done: bool = false

var in_interaction_area: bool = false

onready var elevator_panel_ui: CanvasLayer = get_parent().get_node("ElevatorPanelUI")


func _physics_process(_delta: float) -> void:
	if in_interaction_area:
		
		# Not currently using the panel
		if Input.is_action_pressed("interaction") and not panel_current and not get_tree().paused:
			panel_current = true
			elevator_panel_ui.visible = true
			get_tree().paused = true
			
			EnvVar.can_pause = false
		
		# Currently using the panel
		if Input.is_action_pressed("ui_cancel") and panel_current:
			panel_current = false
			elevator_panel_ui.visible = false
			get_tree().paused = false
			
			EnvVar.can_pause = true
			
			print(elevator_panel_ui.new_level_access)
			if !elevator_panel_ui.new_level_access:
				Dialogic.set_variable("ElevatorFloorAccess", false)
				add_child(Dialogic.start("ElevatorFloorAccess"))
			elif elevator_panel_ui.new_level:
				add_child(Dialogic.start("ElevatorFloorNumber"))
				elevator_panel_ui.new_level = false




func _on_ElevatorPanel_area_entered(area: Area2D) -> void:
	if area.name == "PlayerHitbox":
		in_interaction_area = true

func _on_ElevatorPanel_area_exited(area: Area2D) -> void:
	if area.name == "PlayerHitbox":
		in_interaction_area = false

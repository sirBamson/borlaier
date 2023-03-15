extends Area2D
# Used to open ElevatorPanelUI

# If player can use the panel
var panel_current: bool = false
var animation_done: bool = false

var in_interaction_area: bool = false

onready var elevator_panel_ui: CanvasLayer = $"../ElevatorPanelUI"
onready var elevator_index_panel: Node2D = $"../ElevatorIndexPanel"
onready var wait_timer: Timer = $"../WaitTimer"



"""
Huvudfunktionen för hissknapparna

Kollar först att spelaren är vid knapparna och om "interaction" pressas.
Kollar även så att panelen inte är aktiv och att spelet inte är pausat eller att
hissen rör sig.
Panelen är ett sorts pop-up fönster och inte ny scene.
Funktionen används även för att stänga panelen.

När panelen stängs kollas det om våningsnummret som är pressat existerar.
Efter det kollas det så att hissen inte redan är på samma våning.
Ifall allt är ok sätts den nya vånigen samt att hiss dialogen startar.

Om hissen inte kan ta sig till den nya vånigen på grund av att spelaren inte
besitter rätt tillstånd så körs en annan dialog som förklarar detta.

En "EnvVar.elevator_moving" sätt också beroende på om hissen rör sig eller inte,
detta för att låsa dörarna.

"""

func _physics_process(_delta: float) -> void:
	if in_interaction_area:
		
		# Not currently using the panel
		if Input.is_action_pressed("interaction") and not elevator_panel_ui.active and not get_tree().paused and not EnvVar.elevator_moving:
			elevator_panel_ui.enterd_elevator_ui()
		
		if Input.is_action_pressed("esc") and elevator_panel_ui.active:
			elevator_panel_ui.exited_elevator_ui()
			
			if EnvVar.elevator_button_number_pressed in EnvVar.available_levels:
				if EnvVar.elevator_button_number_pressed in PlayerGlobals.elevator_floor_access:
					Dialogic.set_variable("ElevatorFloorAccess", 1)
					
					if EnvVar.elevator_button_number_pressed != EnvVar.elevator_current_level_number:
						elevator_index_panel.set_index(EnvVar.elevator_button_number_pressed, EnvVar.elevator_current_level_number)
						
						EnvVar.elevator_moving = true
						wait_timer.start(abs(EnvVar.elevator_current_level_number - EnvVar.elevator_button_number_pressed))
						EnvVar.elevator_current_level_number = EnvVar.elevator_button_number_pressed
						Dialogic.set_variable("ElevatorFloorNumber", EnvVar.elevator_current_level_number)
						EnvVar.elevator_next_level = EnvVar.available_levels.get(EnvVar.elevator_current_level_number)
					else:
						print("Elevator is currently on this floor")
				else:
					Dialogic.set_variable("ElevatorFloorAccess", 0)
					add_child(Dialogic.start("ElevatorFloorNumber"))
					print("Player dose not have access to this level")
					
					EnvVar.elevator_moving = true
					yield(get_tree().create_timer(4),"timeout")
					EnvVar.elevator_moving = false
					
			else:
				print("Floor do not exist in EnvVar.available_levels")
		


"""
Simpel snignal funktion
"""


func _on_ElevatorPanel_area_entered(area: Area2D) -> void:
	if area.name == "PlayerHitbox":
		in_interaction_area = true

func _on_ElevatorPanel_area_exited(area: Area2D) -> void:
	if area.name == "PlayerHitbox":
		in_interaction_area = false


"""
En timer funktion som körs då hissen rör sig. Timer sätts beroende på hur långt 
hissen färdas.
"""

func _on_WaitTimer_timeout() -> void:
	add_child(Dialogic.start("ElevatorFloorNumber"))
	EnvVar.elevator_moving = false

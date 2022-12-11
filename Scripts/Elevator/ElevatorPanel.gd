extends Area2D
# Used to open ElevatorPanelUI

# If player can use the panel
var can_use_panel: bool = false
var animation_done: bool = false


func _ready() -> void:
	# Connects signal to the Transition node
	var _err = Transition.get_node("Animation").connect("animation_finished", self, "transition_done")


# Checks if the player is in the designated area
func _on_ElevatorPanel_area_entered(area: Area2D) -> void:
	if area.name == "PlayerHitbox":
		can_use_panel = true

func _on_ElevatorPanel_area_exited(area: Area2D) -> void:
	if area.name == "PlayerHitbox":
		can_use_panel = false


# Checks that the transition is complete
func transition_done(_anim_name: String) -> void:
	animation_done = true


func _physics_process(_delta: float) -> void:
	if can_use_panel and animation_done:
		if Input.is_action_pressed("ui_accept"):
			get_parent().get_node("ElevatorPanelUI").visible = true
			get_tree().paused = true
		if Input.is_action_pressed("ui_cancel"):
			get_parent().get_node("ElevatorPanelUI").visible = false
			get_tree().paused = false

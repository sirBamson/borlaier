extends CanvasLayer



func _ready() -> void:
	visible = false


func _physics_process(_delta: float) -> void:
	if EnvVar.can_pause:
		if Input.is_action_just_pressed("esc"):
			visible = !visible
			get_tree().paused = !get_tree().paused
	
	for button in $VBoxContainer/VBoxContainer.get_children():
		$VBoxContainer/VBoxContainer/Settings.focus_mode
		#if button.


func _on_SaveGame_pressed() -> void:
	pass # Replace with function body.


func _on_Settings_pressed() -> void:
	pass # Replace with function body.


func _on_QuitToMenu_pressed() -> void:
	get_tree().quit()

extends CanvasLayer



func _ready() -> void:
	visible = false


func _physics_process(_delta: float) -> void:
	if EnvVar.can_pause:
		if Input.is_action_just_pressed("esc"):
			visible = !visible
			get_tree().paused = !get_tree().paused

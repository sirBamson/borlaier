extends CanvasLayer


func _ready() -> void:
	visible = false


func _physics_process(delta: float) -> void:
	if PlayerGlobals.won and !get_tree().paused:
		pause_game()


func pause_game() -> void:
	EnvVar.can_pause = false
	visible = !visible
	get_tree().paused = !get_tree().paused

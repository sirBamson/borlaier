extends CanvasLayer


onready var scene_controller: Node = get_node("/root/SceneController")


func _ready() -> void:
	visible = false


func _physics_process(_delta: float) -> void:
	if PlayerGlobals.dead and !get_tree().paused:
		pause_game()


func pause_game() -> void:
	visible = !visible
	get_tree().paused = !get_tree().paused


func _on_QuitToMenu_pressed() -> void:
	pause_game()
	PlayerGlobals.dead = false
	PlayerGlobals.health = 100
	SaveGame.load_data()
	for node in scene_controller.get_children():
		if node.is_in_group("Level") or node.is_in_group("Elevator"):
			scene_controller.change_scene(false, node, node.filename, "res://Scenes/UI/MainMenu.tscn")

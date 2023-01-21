extends Node2D


func _ready() -> void:
	var dialog = Dialogic.start("Test")
	add_child(dialog)

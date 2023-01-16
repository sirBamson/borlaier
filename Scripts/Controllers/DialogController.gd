extends Node


export (String) var id: String

var current_dialogs: Array


func _ready() -> void:
	if Dialogs.dialogs.has(id):
		current_dialogs = Dialogs.dialogs.get(id)


func get_dialog(index: int) -> String:
	var out: String
	
	current_dialogs[0] = index
	out = current_dialogs[current_dialogs[0]]
	
	return out


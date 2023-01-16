extends Control

var bubble_text = "I wouldn't step closer if I were you"
var bubble_text_length = 0
var bubble_text_index = 0
var current_text = ""

onready var timer = get_node("Timer")

var close = false


func _ready() -> void:
	bubble_text_length = bubble_text.length()
	timer.start(1)


func _on_Timer_timeout() -> void:
	if ! close:
		current_text += bubble_text[bubble_text_index]
		$VBoxContainer/Label.text = current_text
		
	if bubble_text_index < bubble_text_length -1:
		timer.start(0.04)
		bubble_text_index += 1
	else:
		if ! close:
			close = true
			timer.start(1)
	


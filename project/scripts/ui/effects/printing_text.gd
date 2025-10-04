extends Control
class_name PrintingText

@export var speed = 0.1
@export var font_file: FontFile
@export var font_size: int

var _text_to_print = ""
var _caret_position = 0
var timer = 0

func _ready() -> void:
	clear()

func print_text(text):
	clear()
	_text_to_print = text
	_caret_position = 0
	
func _process(delta: float) -> void:
	if timer <= 0 and _caret_position < _text_to_print.length():
		_print_char(_text_to_print[_caret_position])
		_caret_position += 1
	else:
		timer -= delta
		
func _print_char(char_text):
	var char_label = Label.new()
	char_label.text = char_text
	char_label.add_theme_font_override("font", font_file)
	char_label.add_theme_font_size_override("font_size", font_size)
	add_child(char_label)

func clear():
	for child in get_children():
		child.queue_free()
	_text_to_print = ""
	_caret_position = 0
	

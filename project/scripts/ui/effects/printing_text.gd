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
	var char_label_container = Control.new()
	var char_label = Label.new()
	char_label.text = char_text
	char_label.add_theme_font_override("font", font_file)
	char_label.add_theme_font_size_override("font_size", font_size)
	add_child(char_label_container)
	char_label_container.add_child(char_label)
	char_label_container.custom_minimum_size = char_label.size
	
	
	char_label.modulate.a = 0
	var pos = char_label.position
	char_label.position.x -= 10
	var new_color = char_label.modulate
	new_color.a = 1
	var tween = create_tween()
	tween.tween_property(char_label, "modulate", new_color, 0.1)
	tween.tween_property(char_label, "position", pos, 0.1)

func clear():
	for child in get_children():
		child.queue_free()
	_text_to_print = ""
	_caret_position = 0
	

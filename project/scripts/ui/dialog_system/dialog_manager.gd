extends Node
class_name DialogManager

@export var free_space: UIFreeSpace
@export var ui_container: Control
@export var characters_container: Control

@export var fade_overlay: FadeOverlay

@export var title_printable_text: PrintingText
@export var text_printable_text: PrintingText

const characters_folder = "res://resources/dialog_characters/"

var is_playing_step = false

var _characters:Dictionary[String, CharacterDisplay] = {}

signal on_step_ended(can_continue)

func _ready() -> void:
	Global.register_dialog_manager(self)
	free_space.on_clicked.connect(end_dialog_step)
	setup_ui()

func clear_characters():
	for key in _characters.keys():
		set_character(key, null)

func set_character(code, frame_code, pose=0):
	if not frame_code:
		if code in _characters:
			_characters[code].queue_free()
			_characters.erase(code)
			return
	
	if not code in _characters:
		var char_res = load(characters_folder + code + ".tres") as CharacterResource
		var display = CharacterDisplay.new()
		display.setup_character(char_res)
		characters_container.add_child(display)
		_characters[code] = display
	
	_characters[code].set_frame(frame_code)
	_characters[code].set_land_pose(pose)

func print_text(char_code, text, activate_display=true):
	if char_code in _characters:
		if activate_display:
			for code in _characters:
				var another_display = _characters[code]
				if char_code == code: another_display.activate()
				else: another_display.deactivate()
		
		var display = _characters[char_code]
		title_printable_text.print_text(display._char_res.name)
	else:
		title_printable_text.print_text(char_code)
	text_printable_text.print_text(text)

func start_dialog_step():
	if is_playing_step: return
	is_playing_step = true
	on_step_ended.emit(false)
	ui_fade_in()
	return on_step_ended

func end_dialog_step():
	if !is_playing_step: return
	is_playing_step = false
	on_step_ended.emit(true)
	_check_for_close.call_deferred()

func _check_for_close():
	if !is_playing_step:
		clear()

func setup_ui():
	clear()
	#ui_container.hide()

func clear():
	title_printable_text.clear()
	text_printable_text.clear()
	ui_fade_out()

func ui_fade_in():
	ui_container.show()
	ui_container.mouse_filter = Control.MOUSE_FILTER_STOP
	var tween = create_tween()
	var duration = 0.1
	tween.tween_property(ui_container, "modulate", Color.from_rgba8(255, 255, 255, 255), duration)
	fade_overlay.fade_to_value(0.7, duration)

func ui_fade_out():
	ui_container.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var tween = create_tween()
	var duration = 0.1
	tween.tween_property(ui_container, "modulate", Color.from_rgba8(255, 255, 255, 0), duration)
	fade_overlay.fade_to_value(0, duration)

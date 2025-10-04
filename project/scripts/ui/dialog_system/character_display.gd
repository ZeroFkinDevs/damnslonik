extends Control
class_name CharacterDisplay

var _char_res: CharacterResource
var _char_frame: CharacterFrameResource
var _frame_control: Control
var _center_position = Vector2.ZERO
var _slide_width = 0

func setup_character(resource:CharacterResource):
	_char_res = resource
	
func set_frame(frame_code: String):
	var is_new = true
	if _frame_control:
		is_new = false
		_frame_control.queue_free()
		_frame_control = null
	
	if !frame_code: return
	_char_frame = _char_res.frames[frame_code]
	
	if _char_frame.texture:
		var rect = TextureRect.new()
		rect.texture = _char_frame.texture
		rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
		add_child(rect)
		_frame_control = rect
	
	_center_position.x = get_parent_control().size.x/2 - _frame_control.size.x/2
	_center_position.y = -_frame_control.size.y
	_slide_width = get_parent_control().size.x - _frame_control.size.x
	if is_new:
		position = _center_position

func set_land_pose(pose):
	var tween = create_tween()
	var new_pos = _center_position
	new_pos.x += _slide_width/2 * pose
	tween.tween_property(self, "position", new_pos, 0.5)\
		.set_trans(Tween.TRANS_CUBIC)

func _ready() -> void:
	modulate = Color.from_rgba8(255,255,255,0)
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color.from_rgba8(255,255,255,255), 0.2)\
		.set_trans(Tween.TRANS_CUBIC)

func activate():
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color.from_rgba8(255,255,255,255), 0.2)\
		.set_trans(Tween.TRANS_CUBIC)
		
func deactivate():
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color.from_rgba8(255,255,255,150), 0.2)\
		.set_trans(Tween.TRANS_CUBIC)

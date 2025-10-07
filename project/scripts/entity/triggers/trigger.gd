extends Area2D
class_name Trigger

@export var delay = 0.0
var timer = 0.0
var _obj_triggered = null

func is_available():
	return true
	
func _ready() -> void:
	body_entered.connect(on_body_entered)
	
func on_body_entered(body):
	if not is_available(): return
	
	if body is Player:
		run_trigger(body)

func run_trigger(obj_triggered):
	_obj_triggered = obj_triggered
	if delay > 0:
		timer = delay
	else:
		trigger(_obj_triggered)
		_obj_triggered = null

func _process(delta: float) -> void:
	if timer > 0: timer -= delta
	if timer < 0:
		timer = 0
		trigger(_obj_triggered)
		_obj_triggered = null

func trigger(obj):
	return obj

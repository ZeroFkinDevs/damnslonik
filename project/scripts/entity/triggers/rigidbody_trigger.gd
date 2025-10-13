extends Trigger
class_name RigidBodyTrigger

@export var rigidbody: RigidBody2D

func is_available():
	return true

func _ready() -> void:
	super._ready()
	rigidbody.freeze = true

func trigger(obj):
	unfreeze.call_deferred()
	
func unfreeze():
	rigidbody.freeze = false
	queue_free()

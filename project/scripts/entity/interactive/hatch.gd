extends InteractiveArea

@export var animation_player: AnimationPlayer
@export var state = false

func _ready() -> void:
	animation_player.play("RESET")

func is_available():
	return true

func use():
	if state: close()
	elif not state: open()

func open():
	state = true
	animation_player.play("open")
	
func close():
	state = false
	animation_player.play("close")

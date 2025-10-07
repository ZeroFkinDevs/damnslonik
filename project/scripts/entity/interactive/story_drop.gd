extends InteractiveArea
class_name StoryDrop

@export var narrative: NarrativeNode
@export var sprite: AnimatedSprite2D
@export var collected = false

var size = 100

func _ready() -> void:
	hide()
	collision_layer = 0
	
func drop():
	sprite.play("init")
	show()
	collision_layer = 2
	return true
	
func drop_near_player():
	var center = Global.get_player().global_position
	var pos = center + Vector2.from_angle(randf() * PI * 2) * (size + 100)
	global_position = pos
	drop()

func use():
	if narrative: narrative.execute()
	collected = true
	var tween = create_tween()
	tween.tween_property(sprite, "frame", 0, 1)
	tween.tween_callback(func(): hide())
	
func is_available():
	if collected: return false
	if not visible: return false
	if narrative: return narrative.is_available()
	return false

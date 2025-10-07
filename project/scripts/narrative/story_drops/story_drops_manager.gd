extends Node

@export var min_delay = 1.0
@export var max_delay = 5.0

var timer = 0;

func _ready() -> void:
	reset_timer()
	
func reset_timer():
	timer = randf_range(min_delay, max_delay)

func _process(delta: float) -> void:
	if timer > 0:
		timer -= delta
	else:
		spawn()
		reset_timer()

func spawn():
	var story_drops: Array[StoryDrop] = []
	for child in get_children():
		if child is StoryDrop:
			if not child.collected:
				story_drops.append(child)
				
	if story_drops.size() > 0:
		var story_drop = story_drops.pick_random() as StoryDrop
		story_drop.drop_near_player()

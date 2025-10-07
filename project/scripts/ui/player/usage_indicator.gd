extends Node2D
class_name UsageIndicator

@export var use_region: PlayerUseRegion
@export var label: Label
@export var sprite: AnimatedSprite2D

func _ready() -> void:
	sprite.play("default")

func _process(delta: float) -> void:
	if use_region.get_usable_object() == null:
		hide()
	else:
		var obj = use_region.get_usable_object()
		if obj is InteractiveArea:
			show()
			label.text = "[E] Use " + obj.get_label()
			if obj.get_display_point() != null:
				global_position = obj.get_display_point().global_position
				#if get_viewport():
					#var canvas_transform = get_viewport().get_screen_transform()
					#var screen_position = canvas_transform * obj.get_display_point().global_position
					#global_position = screen_position.

extends ColorRect
class_name FadeOverlay

func fade_to_value(value, duration, callback=null):
	var tween = create_tween()
	var new_color = color
	new_color.a = value
	tween.tween_property(self, "color", new_color, duration)
	if callback: tween.tween_callback(callback)

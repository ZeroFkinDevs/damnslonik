extends Area2D
class_name InteractiveArea

@export var label = ""
@export var display_point: Node2D

func use():
	print(label + " used")
	
func is_available():
	return true
	
func get_label():
	return label

func get_display_point():
	return display_point

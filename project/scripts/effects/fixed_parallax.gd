extends Parallax2D

func _ready() -> void:
	#pass
	for child in get_children():
		pose_child(child)
	
func pose_child(child:Node2D):
	var w = ProjectSettings.get("display/window/size/viewport_width")
	var h = ProjectSettings.get("display/window/size/viewport_width")
	child.position.x += (w/2-child.position.x) * (1-scroll_scale.x)
	child.position.y += (h/2-child.position.y) * (1-scroll_scale.y)

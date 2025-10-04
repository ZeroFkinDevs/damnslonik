extends Area2D
class_name PlayerUseRegion

var usable_object: Node2D

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("use"):
		if usable_object != null:
			if usable_object is InteractiveArea:
				usable_object.use()
		
	scan_usable_objects()
	
func get_usable_object():
	return usable_object

func scan_usable_objects():
	var nearest_obj: Node2D = null
	var objects = get_overlapping_areas().duplicate()
	objects.append_array(get_overlapping_bodies())
	
	for obj in objects:
		if obj is InteractiveArea:
			if not obj.is_available(): continue
			
			if nearest_obj == null:
				nearest_obj = obj
			else:
				if obj.global_position.distance_to(global_position) \
				< nearest_obj.global_position.distance_to(global_position):
					nearest_obj = obj
	
	usable_object = nearest_obj

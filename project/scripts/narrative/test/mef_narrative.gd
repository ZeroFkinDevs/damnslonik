extends NarrativeNode

@export var boxes: Array[RigidBody2D]

var dropped = false
func is_available():
	return !dropped

func _ready() -> void:
	for box in boxes:
		box.freeze = true

func execute():
	var dialog = Global.get_dialog_manager()
	
	NarrativeManager.start_preparing_new_units()
	NarrativeManager.append_unit({
		"method": func():
			dialog.clear_characters()
			dialog.set_character("stag", "look", 1)
			dialog.print_text("stag", "ooOOoOoOoOOOOoOOoOO")
			if await dialog.start_dialog_step():
				NarrativeManager.execute_next()
	})
	NarrativeManager.append_unit({
		"method": func():
			for box in boxes:
				box.freeze = false
			dropped = true
			await get_tree().create_timer(2).timeout
			NarrativeManager.execute_next()
	})
	NarrativeManager.append_unit({
		"method": func():
			dialog.clear_characters()
			dialog.set_character("stag", "idle", 0)
			dialog.print_text("stag", "воттаквот бл")
			if await dialog.start_dialog_step():
				NarrativeManager.execute_next()
	})
	NarrativeManager.execute_prepared()

extends NarrativeNode

var checked = false
func is_available():
	return !checked
	
func execute():
	var dialog = Global.get_dialog_manager()
	
	NarrativeManager.start_preparing_new_units()
	NarrativeManager.append_unit({
		"method": func():
			checked = true
			dialog.clear_characters()
			dialog.set_character("boss", "idle", -1)
			dialog.print_text("boss", "твою мать мое ебучее тело распухает")
			if await dialog.start_dialog_step(): NarrativeManager.execute_next()
	})
	NarrativeManager.append_unit({
		"method": func():
			dialog.set_character("stag", "idle", 1)
			dialog.print_text("boss", "ебаный дождь...")
			if await dialog.start_dialog_step(): NarrativeManager.execute_next()
	})
	NarrativeManager.append_unit({
		"method": func():
			dialog.print_text("stag", "ты будешь рыхлая и в тебе поселятся черви, потом влага превратит твою мякоть в густую кашу, и нам будет что покушать завтра на работе")
			if await dialog.start_dialog_step(): NarrativeManager.execute_next()
	})
	NarrativeManager.append_unit({
		"method": func():
			dialog.print_text("boss", "...")
			if await dialog.start_dialog_step(): NarrativeManager.execute_next()
	})
	NarrativeManager.append_unit({
		"method": func():
			dialog.set_character("stag", "look", 1)
			dialog.print_text("boss", "ты че еблан?????")
			if await dialog.start_dialog_step(): NarrativeManager.execute_next()
	})
	NarrativeManager.append_unit({
		"method": func():
			dialog.print_text("boss", "закрой пасть и ищи сухое место...")
			if await dialog.start_dialog_step(): NarrativeManager.execute_next()
	})
	NarrativeManager.execute_prepared()

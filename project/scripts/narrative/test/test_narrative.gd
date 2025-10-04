extends NarrativeNode

func execute():
	var dialog = Global.get_dialog_manager()
	
	NarrativeManager.start_preparing_new_units()
	NarrativeManager.append_unit({
		"method": func():
			dialog.clear_characters()
			dialog.set_character("boss", "idle", -1)
			dialog.set_character("stag", "idle", 1)
			dialog.print_text("boss", "кажется эть выход наруужу...")
			if await dialog.start_dialog_step():
				NarrativeManager.execute_next()
	})
	NarrativeManager.append_unit({
		"method": func():
			dialog.print_text("boss", "я беру это на заметку!1!!")
			if await dialog.start_dialog_step():
				NarrativeManager.execute_next()
	})
	NarrativeManager.append_unit({
		"method": func():
			dialog.set_character("stag", "look", 0)
			dialog.print_text("stag", ".....*дышит*....")
			if await dialog.start_dialog_step():
				NarrativeManager.execute_next()
	})
	NarrativeManager.execute_prepared()

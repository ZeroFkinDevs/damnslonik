extends NarrativeNode

@export var lamp: Node2D

@export var checked = false

func is_available():
	return !checked

func _ready() -> void:
	execute.call_deferred()

func execute():
	if checked: return
	var dialog = Global.get_dialog_manager()
	
	NarrativeManager.start_preparing_new_units()
	NarrativeManager.append_unit({
		"method": func():
			checked = true
			Global.get_player().focus_camera_on_obj(lamp)
			dialog.clear_characters()
			dialog.print_text("Фонарььь", "я фонарь")
			if await dialog.start_dialog_step(): NarrativeManager.execute_next()
	})
	NarrativeManager.append_unit({
		"method": func():
			dialog.print_text("Фонарььь", "нахуй ты на меня смотришь")
			if await dialog.start_dialog_step(): NarrativeManager.execute_next()
	})
	NarrativeManager.append_unit({
		"method": func():
			dialog.print_text("Фонарььь", "ладно смотри")
			if await dialog.start_dialog_step(): NarrativeManager.execute_next()
	})
	NarrativeManager.append_unit({
		"method": func():
			dialog.print_text("Фонарььь", "ходишь на клавиши A и D, прыгаешь на Space, взаимодействуешь на E, на лестницах юзаешь W и S")
			if await dialog.start_dialog_step(): NarrativeManager.execute_next()
	})
	NarrativeManager.append_unit({
		"method": func():
			dialog.print_text("Фонарььь", "слушай а можешь заказать мне такси мне срочно нужно...")
			await dialog.start_dialog_step()
			Global.get_player().focus_camera_on_player()
	})
	
	NarrativeManager.execute_prepared()

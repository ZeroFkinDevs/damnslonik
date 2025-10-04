extends Control
class_name UIFreeSpace

signal on_clicked()

func _ready():
	gui_input.connect(self.onClick)
	
func onClick(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			on_clicked.emit()

extends Control

class_name GameScreenControl

func _enter_tree() -> void:
	Global.register_game_screen_control(self)

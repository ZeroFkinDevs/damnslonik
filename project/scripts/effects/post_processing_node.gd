extends Node

@export var material: Material

func _ready() -> void:
	if !material: material = null
	Global.get_game_screen_control().material = material

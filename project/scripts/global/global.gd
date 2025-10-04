extends Node

var _dialog_manager: DialogManager
var _player: Player

func register_dialog_manager(manager):
	_dialog_manager = manager
func get_dialog_manager():
	return _dialog_manager

func register_player(player):
	_player = player	
func get_player():
	return _player

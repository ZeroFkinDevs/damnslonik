extends Node

var _dialog_manager: DialogManager
var _player: Player
var _map_loader: MapLoader

func register_dialog_manager(manager):
	_dialog_manager = manager
func get_dialog_manager():
	return _dialog_manager
	
func register_map_loader(loader):
	_map_loader = loader
func get_map_loader():
	return _map_loader

func register_player(player):
	_player = player	
func get_player():
	return _player

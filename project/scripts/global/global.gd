extends Node

var _dialog_manager: DialogManager
var _player: Player
var _game_screen_control: GameScreenControl
var _map_loader: MapLoader

func register_dialog_manager(manager):
	_dialog_manager = manager
func get_dialog_manager():
	return _dialog_manager
	
func register_game_screen_control(control):
	_game_screen_control = control
func get_game_screen_control():
	return _game_screen_control
	
func register_map_loader(loader):
	_map_loader = loader
func get_map_loader():
	return _map_loader

func register_player(player):
	_player = player	
func get_player():
	return _player

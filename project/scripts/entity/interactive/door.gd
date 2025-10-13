extends InteractiveArea

@export var map_code: String
@export var spawn_code = ""

func is_available():
	return true

func use():
	var loader = Global.get_map_loader()
	loader.load_map(map_code, spawn_code)

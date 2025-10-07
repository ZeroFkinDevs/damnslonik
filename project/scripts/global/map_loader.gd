extends Node
class_name MapLoader

@export var map_code = ""
var map_to_load: PackedScene = null
@export var next_spawn_code = ""
@export var fade_overlay: FadeOverlay

var maps_location = "res://scenes/map/"

var current_map_node:Node = null

func _enter_tree() -> void:
	Global.register_map_loader(self)
	
func _ready() -> void:
	load_map(map_code, next_spawn_code)

func load_map(map_code: String, spawn_code: String):
	next_spawn_code = spawn_code
	map_to_load = load(maps_location + map_code + ".tscn")
	
	fade_overlay.fade_to_value(1.0, 0.5, self._start_loading)

func _start_loading():
	if current_map_node!=null: current_map_node.queue_free()
	
	var player = Global.get_player()
	if player: player.spawner_code = next_spawn_code
	_spawn_next_scene.call_deferred()

func _spawn_next_scene():
	var node = map_to_load.instantiate()
	add_child(node)
	current_map_node = node
	fade_overlay.fade_to_value(0.0, 0.5)

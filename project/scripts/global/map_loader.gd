extends Node
class_name MapLoader

@export var map_code = ""
@export var next_spawn_code = ""
@export var fade_overlay: FadeOverlay

var maps_location = "res://scenes/map/"
var map_to_load: PackedScene = null
var current_map_node:Node = null
var maps_storage: Dictionary[String, PackedScene] = {}
var is_loading = false

func _enter_tree() -> void:
	Global.register_map_loader(self)
	
func _ready() -> void:
	load_map(map_code, next_spawn_code)

func load_map(map_code: String, spawn_code: String):
	if is_loading: return
	next_spawn_code = spawn_code
	is_loading = true
	fade_overlay.fade_to_value(1.0, 0.5, func(): self._start_loading(map_code))

func save_to_storage(map_code, packed_map:PackedScene):
	maps_storage[map_code] = packed_map
	
func get_packed_scene_by_code(map_code):
	if maps_storage.has(map_code):
		return maps_storage[map_code]
	return load(maps_location + map_code + ".tscn")

func own_children_nodes(parent_node:Node, own_to: Node):
	for child in parent_node.get_children():
		child.owner = own_to
		own_children_nodes(child, own_to)

func _start_loading(next_map_code):
	if current_map_node!=null:
		var packed_map = PackedScene.new()
		own_children_nodes(current_map_node, current_map_node)
		packed_map.pack(current_map_node)
		save_to_storage(map_code, packed_map)
		current_map_node.queue_free()
	
	map_code = next_map_code
	map_to_load = get_packed_scene_by_code(map_code)
	
	var player = Global.get_player()
	if player: player.spawner_code = next_spawn_code
	_spawn_next_scene.call_deferred()

func _spawn_next_scene():
	var node = map_to_load.instantiate()
	add_child(node)
	current_map_node = node
	fade_overlay.fade_to_value(0.0, 0.5)
	is_loading = false

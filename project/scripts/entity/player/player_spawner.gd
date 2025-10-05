extends Node2D
class_name PlayerSpawner

@export var code=""

func _ready() -> void:
	spawn_player.call_deferred()

func spawn_player():
	var player = Global.get_player()
	if !player: return
	if player.spawner_code != code: return
	player.teleport(self)

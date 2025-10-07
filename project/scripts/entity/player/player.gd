extends CharacterBody2D
class_name Player

@export var sprite: AnimatedSprite2D
@export var camera: Camera2D
@export var walking_controller: PlayerWalkingController
@export var ladder_controller: PlayerLadderController

@export var spawner_code = ""

func _enter_tree() -> void:
	Global.register_player(self)
	
func _ready() -> void:
	turn_on_walking()
	
func turn_on_walking():
	ladder_controller.disable()
	walking_controller.enable()

func turn_on_ladder(ladder: Ladder):
	walking_controller.disable()
	ladder_controller.enable(ladder)

func teleport(node: Node2D):
	global_position = node.global_position
	camera.reset_smoothing()

extends CharacterBody2D
class_name Player

@export var sprite: AnimatedSprite2D
@export var camera: Camera2D
@export var use_region: PlayerUseRegion
@export var walking_controller: PlayerWalkingController
@export var ladder_controller: PlayerLadderController

@export var spawner_code = ""

var init_camera_pos = null
var camera_following_object:Node2D = null
var _last_active_controller = null

func _enter_tree() -> void:
	Global.register_player(self)
	
func _ready() -> void:
	turn_on_walking()
	init_camera_pos = camera.position
	
func focus_camera_on_obj(obj:Node2D):
	camera_following_object = obj

func focus_camera_on_player():
	camera_following_object = null
	
func _process(delta: float) -> void:
	if camera_following_object:
		camera.global_position = camera_following_object.global_position
	else:
		camera.position = init_camera_pos

func teleport(node: Node2D):
	global_position = node.global_position
	camera.reset_smoothing()

func disable():
	use_region.disable()
	turn_off_controllers()

func enable():
	use_region.enable()
	turn_on_last_controller()

# controllers
func turn_off_controllers():
	ladder_controller.disable()
	walking_controller.disable()
	
func turn_on_last_controller():
	_last_active_controller.enable()
	
func turn_on_walking():
	ladder_controller.disable()
	walking_controller.enable()
	_last_active_controller = walking_controller

func turn_on_ladder(ladder: Ladder):
	walking_controller.disable()
	ladder_controller.enable(ladder)
	_last_active_controller = ladder_controller

extends Area2D
class_name Ladder

@export var right_direction = true
@export var player_point: Node2D
var player:Player = null

func _ready() -> void:
	body_entered.connect(on_body_entered)
	body_exited.connect(on_body_exited)
	
func on_body_entered(body):
	if body is Player:
		player = body
	
func on_body_exited(body):
	if body is Player:
		if body == player:
			if player.ladder_controller.active:
				player.turn_on_walking()
			player = null

func _process(delta: float) -> void:
	if player:
		if player.walking_controller.active:
			if Input.is_action_just_pressed("move_up") or Input.is_action_just_pressed("move_down"):
				player.turn_on_ladder(self)

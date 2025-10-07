extends Node
class_name PlayerLadderController

@export var player: Player

var active = false
var speed = 150.0
var current_ladder: Ladder

func _physics_process(delta):
	if not active: return

	var direction = Input.get_axis("move_up", "move_down")
	player.velocity.y = direction * speed
	player.velocity.x = 0
	
	var target_x = current_ladder.player_point.global_position.x
	player.global_position.x = lerpf(player.global_position.x, target_x, 10 * delta)

	player.move_and_slide()

func enable(ladder: Ladder):
	player.collision_mask = 16
	current_ladder = ladder
	player.sprite.flip_h = not current_ladder.right_direction
	active = true

func disable():
	player.collision_mask = 1
	active = false
	current_ladder = null


func _process(delta: float) -> void:
	if not active: return
	play_idle()

func play_walk():
	if player.sprite.animation != "walk": player.sprite.play("walk")
func play_idle():
	if player.sprite.animation != "idle": player.sprite.play("idle")

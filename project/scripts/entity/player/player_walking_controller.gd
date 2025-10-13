extends Node
class_name PlayerWalkingController

@export var player: Player

var active = false
var speed = 150.0
var jump_speed = -500.0

func enable():
	player.collision_mask = 1
	active = true

func disable():
	play_idle()
	active = false

# Get the gravity from the project settings so you can sync with rigid body nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if not active: return
	# Add the gravity.
	player.velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		player.velocity.y = jump_speed

	# Get the input direction.
	var direction = Input.get_axis("move_left", "move_right")
	player.velocity.x = direction * speed

	player.move_and_slide()

func _process(delta: float) -> void:
	if not active: return
	
	if Input.is_action_pressed("move_left"):
		play_walk()
		player.sprite.flip_h = true
	elif Input.is_action_pressed("move_right"):
		play_walk()
		player.sprite.flip_h = false
	else:
		play_idle()

func play_walk():
	if player.sprite.animation != "walk": player.sprite.play("walk")
func play_idle():
	if player.sprite.animation != "idle": player.sprite.play("idle")

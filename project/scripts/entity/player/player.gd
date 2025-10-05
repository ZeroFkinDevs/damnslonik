extends CharacterBody2D
class_name Player

@export var sprite: AnimatedSprite2D
@export var camera: Camera2D
var speed = 150.0
var jump_speed = -500.0

@export var spawner_code = ""

# Get the gravity from the project settings so you can sync with rigid body nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _enter_tree() -> void:
	Global.register_player(self)

func _physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed

	# Get the input direction.
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed

	move_and_slide()

func _process(delta: float) -> void:
	if Input.is_action_pressed("move_left"):
		play_walk()
		sprite.flip_h = true
	elif Input.is_action_pressed("move_right"):
		play_walk()
		sprite.flip_h = false
	else:
		play_idle()

func play_walk():
	if sprite.animation != "walk": sprite.play("walk")
func play_idle():
	if sprite.animation != "idle": sprite.play("idle")
	
func teleport(node: Node2D):
	global_position = node.global_position
	camera.reset_smoothing()

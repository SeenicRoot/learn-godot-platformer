extends KinematicBody2D

var movement_speed : int = 300
var crouching_speed : int = 50
var jump_force : int = 600
var gravity : int = 800

var velocity : Vector2 = Vector2()

onready var animated_sprite : AnimatedSprite = get_node("AnimatedSprite")

#func built in KinematicBody2D that gives 60 FPS
func _physics_process(delta):

	velocity.x = 0
	#crouch
	if Input.is_action_pressed("duck"):
		animated_sprite.animation = "duck"
	if Input.is_action_pressed("duck") and Input.is_action_pressed("move_left"):
		animated_sprite.animation = "duck"
		velocity.x -= crouching_speed
	if Input.is_action_pressed("duck") and Input.is_action_pressed("move_right"):
		animated_sprite.animation = "duck"
		velocity.x += crouching_speed
	if Input.is_action_pressed("duck"):
		animated_sprite.animation = "duck"
	if Input.is_action_just_released("duck"):
		animated_sprite.animation = "stand"
	if Input.is_action_pressed("move_left"):
		animated_sprite.animation = "walk"
		velocity.x -= movement_speed
	if Input.is_action_just_released("move_left"):
		animated_sprite.animation = "stand"
		velocity.x = 0
	if Input.is_action_pressed("move_right"):
		animated_sprite.animation = "walk"
		velocity.x += movement_speed
	if Input.is_action_just_released("move_right"):
		animated_sprite.animation = "stand"
		velocity.x = 0
		
	#applying velocity
	velocity = move_and_slide(velocity, Vector2.UP)
	
#	#applying gravity (delta is time duration between each frame (1/60))
	velocity.y += gravity * delta
#
#	#jump key
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= jump_force
		
	#sprite direction
	if velocity.x < 0:
		animated_sprite.flip_h = true
	elif velocity.x > 0:
		animated_sprite.flip_h = false

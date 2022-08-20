extends KinematicBody2D

var movement_speed : int = 300
var is_ducking : bool = false
var ducking_speed : int = 100
var is_airborne : bool = false
var jump_force : int = 600
var gravity : int = 800

var velocity : Vector2 = Vector2()

onready var animated_sprite : AnimatedSprite = get_node("AnimatedSprite")

#func built in KinematicBody2D that gives 60 FPS
func _physics_process(delta):

	velocity.x = 0
	
	#movement func
	_move_left()
	_move_right()
	_jump()
	_duck()
	
	#applying velocity
	velocity = move_and_slide(velocity, Vector2.UP)
	#applying gravity (delta is time duration between each frame (1/60))
	velocity.y += gravity * delta
	#sprite direction
	if velocity.x < 0:
		animated_sprite.flip_h = true
	elif velocity.x > 0:
		animated_sprite.flip_h = false
	

func _move_left():
	if Input.is_action_pressed("move_left"):
		animated_sprite.animation = "walk"
		velocity.x -= movement_speed
		if is_ducking:
			velocity.x = 0
			velocity.x -= ducking_speed
		elif is_airborne:
			animated_sprite.animation = "stand"
			if is_on_floor():
				is_airborne = false
	elif Input.is_action_just_released("move_left"):
		animated_sprite.animation = "stand"
		velocity.x = 0
	

func _move_right():
	if Input.is_action_pressed("move_right"):
		animated_sprite.animation = "walk"
		velocity.x += movement_speed
		if is_ducking:
			velocity.x = 0
			velocity.x += ducking_speed
		elif is_airborne:
			animated_sprite.animation = "stand"
			if is_on_floor():
				is_airborne = false
	elif Input.is_action_just_released("move_right"):
		animated_sprite.animation = "stand"
		velocity.x = 0
	

func _jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= jump_force
		is_airborne = true
		animated_sprite.animation = "stand"
	

func _duck():
	if Input.is_action_pressed("duck"):
		animated_sprite.animation = "duck"
		is_ducking = true

	elif Input.is_action_just_released("duck"):
		animated_sprite.animation = "stand"
		is_ducking = false
	

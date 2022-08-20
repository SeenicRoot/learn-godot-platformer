extends KinematicBody2D

var movementSpeed : int = 300
var jumpForce : int = 600
var gravity : int = 800

var velocity : Vector2 = Vector2()

onready var animatedSprite : AnimatedSprite = get_node("AnimatedSprite")

#func built in KinematicBody2D that gives 60 FPS
func _physics_process(delta):
	
	velocity.x = 0
	if Input.is_action_pressed("move_left"):
		animatedSprite.animation = "walk"
		velocity.x -= movementSpeed
	if Input.is_action_pressed("move_right"):
		animatedSprite.animation = "walk"
		velocity.x += movementSpeed
		
	#applying velocity
	velocity = move_and_slide(velocity, Vector2.UP)
	
#	#applying gravity (delta is time duration between each frame (1/60))
#	velocity.y += gravity * delta
#
#	#jump key
#	if Input.is_action_just_pressed("jump") and is_on_floor():
#		velocity.y -= jumpForce
		
	#crouch
	if Input.is_action_pressed("duck"):
		animatedSprite.animation = "duck"
	if Input.is_action_just_released("duck"):
		animatedSprite.animation = "stand"
	
	
	#sprite direction
	if velocity.x < 0:
		animatedSprite.flip_h = true
	elif velocity.x > 0:
		animatedSprite.flip_h = false

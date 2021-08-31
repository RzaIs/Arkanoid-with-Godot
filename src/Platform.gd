extends KinematicBody2D


export var speed := 500.0

var _direction : float
var _velocity := Vector2.ZERO
var _isPaused := false

enum {desktop , mobile}
var L : int
var R : int
var gamePlatform : int

func _physics_process(_delta):
	getDirection()
	_velocity.x = speed * _direction
	_velocity = move_and_slide(_velocity)
	
	for object in get_slide_count():
		var collision = get_slide_collision(object)
		if collision.collider.name == "Ball":
			$AnimationPlayer.play("oscillate")
	
func getDirection():
	if _isPaused:
		_direction = 0.0
	else:
		if gamePlatform == desktop:
			_direction = Input.get_action_strength("moveRight") - Input.get_action_strength("moveLeft")
		else:
			_direction = R - L

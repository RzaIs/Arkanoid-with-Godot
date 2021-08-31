extends KinematicBody2D

const std_speed := 500.0

export var speed := std_speed

var _velocity := Vector2.ZERO

#===============================#
func _physics_process(delta):
	var collision_obj = move_and_collide(_velocity * speed * delta)
	if collision_obj:
		_velocity = _velocity.bounce(collision_obj.normal)
#===============================#


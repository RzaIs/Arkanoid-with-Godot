extends Node2D

var topCor : float
var isHit : bool

func _ready():
	topCor = position.y - 500
	isHit = false

func _on_Area2D_body_entered(body):
	if body.is_in_group("Ball"):
		position.y = topCor
		isHit = true
		get_parent().get_parent().get_node("Interface").updateScore()

func enable():
	if isHit:
		position.y += 500
		isHit = false

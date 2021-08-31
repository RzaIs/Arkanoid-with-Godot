extends Node

export var balancePoint : int

var balanceGravity := 200
var _isPaused := false
var _PauseResumeButton := false

enum {desktop , mobile}

func _ready():
	randomize()


func _physics_process(_delta):
	checkWin()
	checkPause()
	if $Platform.position.y != 700:
		$Platform.position.y = 700
	if $Ball.position.y > 750:
		$Ball._velocity = Vector2.ZERO
		$Interface/GameOver.visible = true
		$Interface.gameOverScore()
	$CountDown.text = str(int($StartTimer.time_left + 1))

func startGame():
	$Platform._isPaused = false
	$StartTimer.start()
	$CountDown.show()
	yield($StartTimer, "timeout")
	$CountDown.hide()
	$Ball.speed = $Ball.std_speed
	$Ball._velocity = Vector2(randf() - 0.5, 1).normalized()

func checkWin():
	var win = true
	for node in $Blocks.get_children():
		if not node.isHit:
			win = false
	if win:
		$Ball._velocity = Vector2.ZERO
		$Interface/GameOver/GameOver.text = "YOU WIN"
		$Interface/GameOver.visible = true
		$Interface.gameOverScore()

func checkPause():
	if (Input.is_action_just_pressed("ESC") or _PauseResumeButton) and $Interface/GameOver.visible == false and $Menu.visible == false and $CountDown.visible == false:
		if _isPaused:
			$Ball.speed = $Ball.std_speed
			_isPaused = false
			$Platform._isPaused = false
			$Platform/AnimationPlayer.stop(true)
			$Interface/PauseMenu.visible = false
		else:
			$Ball.speed = 0.0
			_isPaused = true
			$Platform._isPaused = true
			$Interface/PauseMenu.visible = true
	_PauseResumeButton = false

func pauseResumeButton():
	_PauseResumeButton = true

func _on_Interface_leftUP():
	$Platform.L = 0

func _on_Interface_leftDOWN():
	$Platform.L = 1

func _on_Interface_rightUP():
	$Platform.R = 0
	
func _on_Interface_rightDOWN():
	$Platform.R = 1


func _on_Menu_desktop():
	$Platform.gamePlatform = desktop
	prepareGame()
	startGame()

func _on_Menu_mobile():
	$Platform.gamePlatform = mobile
	prepareGame()
	startGame()

func prepareGame():
	$Menu.visible = false
	$Interface/Score.visible = true
	$Ball.position = Vector2(480,360)
	$Platform.position = Vector2(480,700)
	for node in $Blocks.get_children():
		node.enable()

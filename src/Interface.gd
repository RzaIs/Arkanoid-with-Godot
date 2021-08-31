extends Node

signal PauseResumeButton

signal L_down
signal L_up
signal R_down
signal R_up

var score := 0

func _process(_delta):
	if $PauseMenu.visible == true:
		$MobileBtn/esc.visible = false
	else:
		$MobileBtn/esc.visible = true

func updateScore():
	score += 1
	$Score.text = "Score: " + str(score)

func gameOverScore():
	$Score.valign = VALIGN_CENTER

func _on_Restart_pressed():
	get_parent().prepareGame()
	$GameOver.visible = false
	$GameOver/GameOver.text = "GAME OVER"
	$Score.valign = VALIGN_TOP
	get_parent().startGame()
	score = -1
	updateScore()


func _on_Menu_pressed():
	get_parent().prepareGame()
	$GameOver.visible = false
	$GameOver/GameOver.text = "GAME OVER"	
	$Score.valign = VALIGN_TOP
	score = -1
	updateScore()
	get_parent().get_node("Menu").visible = true


func _on_Continue_pressed():
	emit_signal("PauseResumeButton")


func _on_ExitToMenu_pressed():
	$PauseMenu.visible = false
	get_parent().get_node("Menu").visible = true
	emit_signal("PauseResumeButton")
	score = -1
	updateScore()


func _on_PM_Restart_pressed():
	$PauseMenu.visible = false	
	emit_signal("PauseResumeButton")
	get_parent().prepareGame()
	get_parent().startGame()
	score = -1
	updateScore()

func _on_left_button_down():
	emit_signal("L_down")

func _on_left_button_up():
	emit_signal("L_up")

func _on_right_button_down():
	emit_signal("R_down")

func _on_right_button_up():
	emit_signal("R_up")

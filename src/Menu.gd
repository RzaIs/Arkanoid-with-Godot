extends Control

signal desktop
signal mobile

func _on_Desktop_pressed():
	emit_signal("desktop")
	get_parent().get_node("Interface/MobileBtn").visible = false

func _on_Mobile_pressed():
	emit_signal("mobile")
	get_parent().get_node("Interface/MobileBtn").visible = true

extends Node2D

func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/World.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()

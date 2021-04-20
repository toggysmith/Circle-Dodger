extends Node2D

func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/World.tscn")

func _on_TutorialButton_pressed():
	get_tree().change_scene("res://Scenes/Tutorial.tscn")

func _on_SettingsButton_pressed():
	get_tree().change_scene("res://Scenes/Settings.tscn")

func _on_CreditsButton_pressed():
	get_tree().change_scene("res://Scenes/Credits.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()

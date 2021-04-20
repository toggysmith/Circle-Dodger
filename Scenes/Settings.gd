extends Node2D

func _ready():
	$CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer/VolumeSlider.value = Global.music_volume
	$CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer2/VolumeSlider.value = Global.sound_effects_volume

func _process(delta):
	Global.music_volume = $CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer/VolumeSlider.value
	Global.sound_effects_volume = $CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer2/VolumeSlider.value
	
	Global.update_settings()

func _on_BackButton_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")

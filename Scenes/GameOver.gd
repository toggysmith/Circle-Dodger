extends Node2D

var is_key_blocked = true
var score = 0

func _ready():
	$CanvasLayer/VBoxContainer/ScoreLabel.text = "Score: " + str(Global.score)

func _process(delta):
	if Input.is_action_pressed("space") and !is_key_blocked:
		get_tree().change_scene("res://Scenes/Menu.tscn")

func _on_KeyBlockTimer_timeout():
	is_key_blocked = false

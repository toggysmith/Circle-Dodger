extends CanvasLayer

func _ready():
	Global.score = 0

func _process(delta):
	$Panel/VBoxContainer/MarginContainer/OxygenBar.value = get_parent().get_node("Player").oxygen_remaining
	
	$Panel/VBoxContainer/Score.text = "Score: " + str(Global.score)

func _on_ScoreTimer_timeout():
	Global.score += 1

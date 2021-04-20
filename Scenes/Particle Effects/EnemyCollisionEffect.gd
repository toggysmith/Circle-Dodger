extends Node2D

func _ready():
	$Gears.emitting = true
	$Crosses.emitting = true
	$Bolts.emitting = true

func _process(delta):
	if !$Gears.emitting and !$Crosses.emitting and !$Bolts.emitting:
		$Timer.start()

func _on_Timer_timeout():
	queue_free()

extends Particles2D

func _ready():
	emitting = true

func _process(delta):
	if !emitting:
		$Timer.start()

func _on_Timer_timeout():
	queue_free()

extends Area2D

func _draw():
	draw_circle(Vector2.ZERO, $CollisionShape2D.shape.radius, Color8(35, 237, 220))

func _on_OxygenTank_body_entered(body):
	if body.is_in_group("player"):
		body.transfer_oxygen(20)
		
		queue_free()

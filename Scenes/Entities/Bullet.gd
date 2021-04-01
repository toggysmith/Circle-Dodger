extends Area2D

export var velocity = Vector2.ZERO
export var speed = 600

func _draw():
	draw_circle(Vector2.ZERO, $CollisionShape2D.shape.radius, Color8(0, 0, 0))

func _process(delta):
	position += velocity * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Bullet_body_entered(body):
	if body.is_in_group("enemies"):
		body.die()
		
		queue_free()

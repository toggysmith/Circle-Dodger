extends KinematicBody2D

onready var EnemyDeathEffect = preload("res://Scenes/Particle Effects/EnemyDeathEffect.tscn")

onready var player = get_parent().get_node("Player")

export var acceleration = 5000 # pixels/second/second
export var base_max_speed = 200 # pixels/second
export var relative_max_speed = 1.0
export var color = Color8(0, 0, 0)
export var trauma_amount = 0.0

var velocity = Vector2.ZERO

func get_direction_vector_to_player():
	var direction_vector = player.position - position
	
	return direction_vector.normalized()

func apply_forces(delta):
	var direction_vector = get_direction_vector_to_player()
	
	# Acceleration
	velocity += direction_vector * acceleration * delta

func limit_max_speed():
	velocity = velocity.clamped(base_max_speed * relative_max_speed)

func _draw():
	var radius = $CollisionShape2D.shape.radius
	
	draw_circle(Vector2.ZERO, radius, color)

func _physics_process(delta):
	apply_forces(delta)
	
	limit_max_speed()
	
	velocity = move_and_slide(velocity)
	
	var slide_count = get_slide_count()
	
	if slide_count:
		var collision = get_slide_collision(slide_count - 1)
		var collider = collision.collider
		
		if collider.is_in_group("player"):
			collider.die()
	
	update()

func die():
	get_parent().get_node("Camera2D").add_trauma(trauma_amount)
	
	var enemy_death_effect = EnemyDeathEffect.instance()
	
	enemy_death_effect.position = position
	
	get_parent().add_child(enemy_death_effect)
	
	queue_free()

extends KinematicBody2D

onready var Bullet = preload("res://Scenes/Entities/Bullet.tscn")

export var acceleration = 5000 # pixels/second/second
export var friction = 1000
export var max_speed = 2000 # pixels/second
export var oxygen_loss_rate = 4.0 # oxygen lost/second

var velocity = Vector2.ZERO
var oxygen_remaining = 100.0

func get_input():
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	return input_vector.normalized()

func apply_forces(delta):
	var input_vector = get_input()
	
	# Acceleration
	if input_vector != Vector2.ZERO:
		velocity += input_vector * acceleration * delta
	# Friction
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

func limit_max_speed():
	velocity = velocity.clamped(max_speed)

func rotate_toward_mouse():
	rotation = global_position.angle_to_point(get_global_mouse_position())
	rotation_degrees += 90

func consume_oxygen(delta):
	oxygen_remaining -= oxygen_loss_rate * delta

func _physics_process(delta):
	apply_forces(delta)
	
	limit_max_speed()
	
	rotate_toward_mouse()
	
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("fire"):
		var bullet = Bullet.instance()
		
		bullet.rotation = rotation
		bullet.position = position
		bullet.velocity = Vector2(0, bullet.speed).rotated(rotation)
		
		get_parent().add_child(bullet)
	
	consume_oxygen(delta)
	
	if oxygen_remaining <= 0:
		die()

func transfer_oxygen(amount):
	oxygen_remaining += amount
	
	oxygen_remaining = clamp(oxygen_remaining, 0, 100)

func die():
	get_tree().change_scene("res://Scenes/GameOver.tscn")

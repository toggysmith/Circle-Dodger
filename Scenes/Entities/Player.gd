extends KinematicBody2D

onready var Bullet = preload("res://Scenes/Entities/Bullet.tscn")

export var acceleration     = 5000 # pixels/second/second
export var friction         = 1000
export var max_speed        = 2000 # pixels/second
export var oxygen_loss_rate = 4.0  # oxygen lost/second

var velocity         = Vector2.ZERO
var oxygen_remaining = 100.0
var current_weapon   = "Pistol"

var can_fire_assault_rifle = true
var can_fire_shotgun       = true

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

func _process(delta):
	if position.x < 400:
		current_weapon = "Assault Rifle"
	else:
		current_weapon = "Shotgun"

func debug_func():
	var EnemyCollisionEffect = load("res://Scenes/Particle Effects/EnemyCollisionEffect.tscn")
	get_parent().get_node("Camera2D").add_trauma(0.25)
	
	var enemy_collision_effect = EnemyCollisionEffect.instance()
	
	enemy_collision_effect.position = position
	
	get_parent().add_child(enemy_collision_effect)
	

func _physics_process(delta):
	if Input.is_action_just_pressed("space"):
		debug_func()
	
	apply_forces(delta)
	
	limit_max_speed()
	
	rotate_toward_mouse()
	
	velocity = move_and_slide(velocity)
	
	fire_gun()
	
	consume_oxygen(delta)
	
	if oxygen_remaining <= 0:
		die()

func fire_gun():
	if current_weapon == "Assault Rifle" and can_fire_assault_rifle:
		if Input.is_action_pressed("fire"):
			create_bullet(0)
			
			can_fire_assault_rifle = false
			
			$AssaultRifleTimer.start()
	elif current_weapon == "Shotgun" and can_fire_shotgun:
		if Input.is_action_just_pressed("fire"):
			var rotation_offset = 10
			
			create_bullet(-rotation_offset)
			create_bullet(0)
			create_bullet(rotation_offset)
			
			can_fire_shotgun = false
			
			$ShotgunTimer.start()

func create_bullet(added_rotation):
	var bullet = Bullet.instance()
	
	bullet.rotation = rotation
	bullet.position = position
	bullet.velocity = Vector2(0, bullet.speed).rotated(rotation + deg2rad(added_rotation))
	
	get_parent().add_child(bullet)

func transfer_oxygen(amount):
	oxygen_remaining += amount
	
	oxygen_remaining = clamp(oxygen_remaining, 0, 100)

func die():
	get_tree().change_scene("res://Scenes/GameOver.tscn")

func _on_AssaultRifleTimer_timeout():
	can_fire_assault_rifle = true

func _on_ShotgunTimer_timeout():
	can_fire_shotgun = true

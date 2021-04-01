extends Node

onready var BlueEnemy = preload("res://Scenes/Entities/BlueEnemy.tscn")
onready var OrangeEnemy = preload("res://Scenes/Entities/OrangeEnemy.tscn")
onready var RedEnemy = preload("res://Scenes/Entities/RedEnemy.tscn")

func _ready():
	randomize()

func _on_Timer_timeout():
	var chosen_enemy = randi() % 3
	
	var enemy = null
	
	if chosen_enemy == 0:
		enemy = BlueEnemy.instance()
	elif chosen_enemy == 1:
		enemy = OrangeEnemy.instance()
	elif chosen_enemy == 2:
		enemy = RedEnemy.instance()
	
	var along = randi() % (800 * 2 + 600 * 2)
	
	if along <= 800:
		enemy.position = Vector2(along, 64)
	elif along <= 800 + 600:
		enemy.position = Vector2(800, 64 + along - 800)
	elif along <= 800 + 600 + 800:
		enemy.position = Vector2(800 - (along - 800 - 600), 600)
	else:
		enemy.position = Vector2(0, 600 - (along - 800 - 600 - 800))
	
	get_parent().add_child(enemy)

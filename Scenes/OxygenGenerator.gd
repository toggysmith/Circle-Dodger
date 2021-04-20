extends Node

onready var OxygenTank = preload("res://Scenes/Entities/OxygenTank.tscn")

func _ready():
	randomize()

func _process(delta):
	while get_child_count() <= 2:
		var oxygen_tank = OxygenTank.instance()
		
		var min_distance_from_borders = 160
		
		oxygen_tank.position = Vector2(rand_range(min_distance_from_borders, 800 - min_distance_from_borders), rand_range(min_distance_from_borders + 64, 600 - min_distance_from_borders - 64))
		
		var is_too_close = true
		
		while is_too_close:
			is_too_close = false
			
			for child in get_children():
				if child.is_in_group("oxygen_tanks"):
					if child.position.distance_to(oxygen_tank.position) < 400:
						is_too_close = true
			
			oxygen_tank.position = Vector2(16 + randi() % (800 - 32), 16 + 64 + (randi() % (600 - 64 - 32)))
		
		add_child(oxygen_tank)

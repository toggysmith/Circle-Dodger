extends Node

var score = 0

var music_volume         = 1.0
var sound_effects_volume = 1.0

func _ready():
	update_settings()

func update_settings():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear2db(music_volume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound Effects"), linear2db(sound_effects_volume))

class_name GameSettings
extends Resource

@export var volume: float = 1.0
@export var throw_power: float = 1.0
@export var avoid_mouse := false

func export_settings():
	print(volume)
	print(throw_power)
	print(avoid_mouse)
	ResourceSaver.save(self, "user://settings.tres")

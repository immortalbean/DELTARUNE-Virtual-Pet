class_name GameSettings
extends Resource

@export var volume := 1.0
@export var throw_power := 1.0
@export var avoid_mouse := false
@export var save_pets := false
@export var pets := []

func export_settings():
	ResourceSaver.save(self, "user://settings.tres")

extends Node

@export var pet_scene: PackedScene
@export var pet_icon_scene: PackedScene
@export var pets_list: Node
@export var volume_slider: Node
@export var throw_power_slider: Node
@export var mouse_avoidance_check: Node
@export var save_pets_check: Node
var pets := {}
var pet_icons := {}
var dragging := false
var menu_open := false
var avoid_mouse := false
var next_id := 0
var throw_power = 1.0
var save_pets := false
var settings = GameSettings.new()
var save_settings_timer = 0.0

func _ready() -> void:
	if FileAccess.file_exists("user://settings.tres"):
		settings = load("user://settings.tres")
		volume_slider.value = settings.volume
		set_volume(settings.volume)
		throw_power_slider.value = settings.throw_power
		set_throw_power(settings.throw_power)
		mouse_avoidance_check.button_pressed = settings.avoid_mouse
		set_mouse_avoidance(settings.avoid_mouse)
		save_pets_check.button_pressed = settings.save_pets
		set_save_pets(settings.save_pets)
		print(save_pets)
		if save_pets:
			for i in settings.pets:
				add_pet(i)
func add_pet(form: int = -1) -> void:
	var new_pet = pet_scene.instantiate()
	var kris = new_pet.get_child(0)
	kris.id = next_id
	call_deferred("add_child", new_pet)
	pets[next_id] = new_pet
	var new_pet_icon = pet_icon_scene.instantiate()
	pet_icons[next_id] = new_pet_icon
	new_pet_icon.prep(next_id, self)
	pets_list.call_deferred("add_child", new_pet_icon)
	next_id += 1
	if form >= 0:
		#really strange timer usage but makes sure the pets are properly instantiated before changing their form
		await get_tree().create_timer(0.1).timeout
		kris.form = form
		kris.change_form(0)
func remove_pet(id: int):
	pets[id].queue_free()
	pets.erase(id)
	pet_icons[id].queue_free()
	pet_icons.erase(id)
func _physics_process(delta: float) -> void:
	if save_settings_timer > 0:
		save_settings_timer -= delta
		if save_settings_timer <= 0:
			if save_pets:
				settings.pets = []
				for i in pets.values():
					settings.pets.append(i.get_child(0).form)
			settings.export_settings()
	elif save_pets:
		save_settings_timer = 15.0
	if !Input.is_action_pressed("mouse_click"):
		dragging = false

func set_volume(value: float) -> void:
	AudioServer.set_bus_volume_linear(0, value)
	settings.volume = value
	# Stops sliders from doing 60 file operations a second, you're welcome
	save_settings_timer = 1.0
func set_throw_power(value: float) -> void:
	throw_power = value
	settings.throw_power = value
	save_settings_timer = 1.0
func set_mouse_avoidance(toggled_on: bool) -> void:
	avoid_mouse = toggled_on
	settings.avoid_mouse = toggled_on
	save_settings_timer = 1.0
func set_save_pets(toggled_on: bool) -> void:
	save_pets = toggled_on
	settings.save_pets = toggled_on
	save_settings_timer = 1.0

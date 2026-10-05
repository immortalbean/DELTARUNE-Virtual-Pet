extends Node

@export var pet_scene: PackedScene
@export var pet_icon_scene: PackedScene
@export var pets_list: Node
var pets := {}
var pet_icons := {}
var dragging := false
var menu_open := false
var next_id := 0
var throw_power = 1.0

func add_pet() -> void:
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
func remove_pet(id: int):
	pets[id].queue_free()
	pets.erase(id)
	pet_icons[id].queue_free()
	pet_icons.erase(id)
func _physics_process(delta: float) -> void:
	if !Input.is_action_pressed("mouse_click"):
		dragging = false

func set_volume(value: float) -> void:
	AudioServer.set_bus_volume_linear(0, value)
func set_throw_power(value: float) -> void:
	throw_power = value

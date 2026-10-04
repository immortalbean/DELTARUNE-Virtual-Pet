extends Control

var main: Node
var id: int = -1
var form: int = -1
var kris: Node = null
@onready var icon_texture = $Margins/Panel/IconTexture

func prep(pet_id, main_node) -> void:
	id = pet_id
	main = main_node
	kris = main.pets[id].get_child(0)
func _physics_process(delta: float) -> void:
	if form != kris.form:
		var icon_anim = "idle_down"
		if kris.sprite.sprite_frames.has_animation("icon"):
			icon_anim = "icon"
		icon_texture.texture = kris.sprite.sprite_frames.get_frame_texture(icon_anim, 0)


func remove_pressed() -> void:
	main.remove_pet(id)

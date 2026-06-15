extends Node

var mouse_offset: Vector2 = Vector2.ZERO
var dragging = false
var kris: CharacterBody2D
var time: float = 0.0
var menu_open: bool = false
@export var names: PackedStringArray
@export var context_menu: PackedScene

func _ready() -> void:
	var _rid = get_tree().get_root().get_viewport_rid()
	RenderingServer.viewport_set_transparent_background(_rid, true)
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT,true)
	kris = get_parent()
	kris.position = Vector2(
		randi_range(0, DisplayServer.screen_get_size().x),
		randi_range(0, DisplayServer.screen_get_size().y)
	)
	
func tick(delta: float) -> void:
	if not menu_open:
		time += delta
		if Input.is_action_just_pressed("mouse_click"):
			mouse_offset = kris.position - kris.get_global_mouse_position()
			dragging = true
		if Input.is_action_just_released("mouse_click"):
			dragging = false
		if dragging:
			var rounded_time = time * 180.0
			kris.position = kris.get_global_mouse_position() + mouse_offset + (
				Vector2(snapped(sin(deg_to_rad(rounded_time)) * 2.0, 1.0), snapped(sin(deg_to_rad(rounded_time * 0.9)) * 2.0, 1.0))
				)
		kris.position.x = clamp(kris.position.x, 0.0, float(DisplayServer.screen_get_size().x - DisplayServer.window_get_size().x))
		kris.position.y = clamp(kris.position.y, 0.0, float(DisplayServer.screen_get_size().y - DisplayServer.window_get_size().y))
		DisplayServer.window_set_position(kris.position)
		if Input.is_action_just_pressed("right_click"):
			if has_node("menu"):
				pass
			else:
				var menu = context_menu.instantiate()
				menu_open = true
				kris.sprite.stop()
				menu.window_manager = self
				menu.position = Vector2i(kris.get_global_mouse_position()) + DisplayServer.window_get_size() / 2
				menu.kris = kris
				add_child(menu)
func set_window_name(form: int):
	DisplayServer.window_set_title(names[form])
func set_window_size(size: Vector2i):
	DisplayServer.window_set_size(size)

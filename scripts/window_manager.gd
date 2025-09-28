extends Node

var mouse_offset: Vector2 = Vector2.ZERO
var dragging = false
var kris: CharacterBody2D
var time: float = 0.0

func _ready() -> void:
	var _rid = get_tree().get_root().get_viewport_rid()
	RenderingServer.viewport_set_transparent_background(_rid, true)
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT,true)
	
	kris = get_parent()
func _process(delta: float) -> void:
	time += delta
	if Input.is_action_just_pressed("mouse_click"):
		mouse_offset = kris.position - kris.get_global_mouse_position()
		dragging = true
	if Input.is_action_just_released("mouse_click"):
		dragging = false
	if dragging:
		kris.position = kris.get_global_mouse_position() + mouse_offset
	kris.position.x = clamp(kris.position.x, 0.0, float(DisplayServer.screen_get_size().x - DisplayServer.window_get_size().x))
	kris.position.y = clamp(kris.position.y, 0.0, float(DisplayServer.screen_get_size().y - DisplayServer.window_get_size().y))
	DisplayServer.window_set_position(kris.position)

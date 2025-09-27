extends Node

var mouse_offset: Vector2 = Vector2.ZERO
var dragging = false
var kris: CharacterBody2D

func _ready() -> void:
	var _rid = get_tree().get_root().get_viewport_rid()
	RenderingServer.viewport_set_transparent_background(_rid, true)
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT,true)
	
	kris = get_parent()
func _process(_delta: float) -> void:

	DisplayServer.window_set_position(get_parent().position)
	if Input.is_action_just_pressed("mouse_click"):
		mouse_offset = kris.get_global_mouse_position() - kris.position
		dragging = true
	if Input.is_action_just_released("mouse_click"):
		dragging = false
	if dragging:
		kris.position = kris.get_global_mouse_position() + mouse_offset

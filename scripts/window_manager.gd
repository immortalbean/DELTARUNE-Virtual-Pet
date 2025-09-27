extends Node

var mouse_offset: Vector2 = Vector2.ZERO

func _ready() -> void:
	var _rid = get_tree().get_root().get_viewport_rid()
	RenderingServer.viewport_set_transparent_background(_rid, true)
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT,true)
	
func _process(_delta: float) -> void:
	DisplayServer.window_set_position(get_parent().position)
	if Input.is_action_just_pressed("mouse_click"):
		mouse_offset = get_viewport().get_mouse_position()

extends Window

var kris: CharacterBody2D = null
var window_manager: Node = null

@onready var scale_slider = $PanelContainer/VBoxContainer/scale_panel/scale
@onready var panel = $PanelContainer

func _process(delta: float) -> void:
	size = panel.size
func prep() -> void:
	scale_slider.value = window_manager.scale
func delete() -> void:
	get_tree().quit()
	queue_free()
	window_manager.menu_open = false
func exit() -> void:
	queue_free()
	window_manager.menu_open = false
func next() -> void:
	kris.change_form(1)
func previous() -> void:
	kris.change_form(-1)
func emote() -> void:
	kris.rand_emote()
	queue_free()
	window_manager.menu_open = false
func scale(level: float) -> void:
	window_manager.scale = level
	kris.update_visuals()

extends Window

var kris: CharacterBody2D = null
var window_manager: Node = null

@onready var scale_slider = $PanelContainer/VBoxContainer/scale_panel/scale
@onready var panel = $PanelContainer
@onready var emote_btn = $PanelContainer/VBoxContainer/emote

func update_ui() -> void:
	emote_btn.visible = len(InfoLoader.emotes[kris.form]) > 0
	size = panel.size
func prep() -> void:
	scale_slider.value = window_manager.scale
	update_ui()
func delete() -> void:
	window_manager.main.remove_pet(kris.id)
	exit()
func exit() -> void:
	window_manager.menu_open = false
	window_manager.main.menu_open = false
	queue_free()
func next() -> void:
	kris.change_form(1)
	update_ui()
func previous() -> void:
	kris.change_form(-1)
	update_ui()
func emote() -> void:
	kris.rand_emote()
	exit()
func scale(level: float) -> void:
	window_manager.scale = level
	kris.update_visuals()

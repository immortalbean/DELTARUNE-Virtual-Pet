extends Window

var kris: CharacterBody2D = null
var window_manager: Node = null

func delete() -> void:
	get_tree().quit()
	queue_free()
	window_manager.menu_open = false


func exit() -> void:
	queue_free()
	window_manager.menu_open = false


func next() -> void:
	kris.change_form(1)
	queue_free()
	window_manager.menu_open = false
func previous() -> void:
	kris.change_form(-1)
	queue_free()
	window_manager.menu_open = false

extends Node2D

func _ready() -> void:
	# More ugly code for sprite flags.
	owner = get_node("../..")
func _process(delta: float) -> void:
	# Can't really get simpler than this
	if owner.direction == "left":
		scale.x = 1.0
	if owner.direction == "right":
		scale.x = -1.0

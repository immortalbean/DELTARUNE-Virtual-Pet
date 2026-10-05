extends Node2D

var time: float = 0.0

func _process(delta: float) -> void:
	time += delta
	get_parent().offset.y = sin(time * 2.0) * 2.0

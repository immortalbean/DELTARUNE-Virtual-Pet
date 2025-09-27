extends Node

@export var scenes: Array[PackedScene]

var sprite: AnimatedSprite2D = null

func spawn():
	if sprite != null:
		sprite.queue_free()
	var node = scenes[owner.form].instantiate()
	sprite = node
	owner.sprite = node
	call_deferred("add_sibling", node)

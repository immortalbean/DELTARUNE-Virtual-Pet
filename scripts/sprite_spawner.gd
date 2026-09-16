extends Node

@export var info: Node
var sprite: AnimatedSprite2D = null
func _ready() -> void:
	owner.max_form = info.scenes.size() - 1
func spawn():
	if sprite != null:
		sprite.queue_free()
	var node = load(info.scenes[owner.form]).instantiate()
	sprite = node
	owner.sprite = node
	call_deferred("add_sibling", node)
	if info.sprite_flags[owner.form]:
		var flag_node = load(info.sprite_flags[owner.form]).instantiate()
		node.call_deferred("add_child", flag_node)

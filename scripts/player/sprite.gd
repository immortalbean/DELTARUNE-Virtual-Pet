extends AnimatedSprite2D

@export var form_val = 0
func _ready() -> void:
	if get_parent().form == form_val:
		owner.sprite = self
	else:
		queue_free()

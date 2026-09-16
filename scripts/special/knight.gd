extends Node2D

var time: float = 0.0
var directions = {
	"left": Vector2.LEFT,
	"right": Vector2.RIGHT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}

func _process(delta: float) -> void:
	time += delta
	owner.offset.y = sin(time * 3.0) * 2.0
	position = owner.offset # Just makes rendering easier.
	queue_redraw()
func _draw() -> void:
	# Shouldn't break in theory, but still check later on to be safe.
	var kris = owner.get_parent() 
	var sprite = owner as AnimatedSprite2D
	# There has to be an easier way to do this right?
	var frame = sprite.sprite_frames.get_frame_texture(sprite.animation, sprite.frame)
	var frame_position = -frame.get_size() * 0.5
	var dir = Vector2.RIGHT
	if kris is CharacterBody2D:
		# Use character's direction to determine direction of the Knight's ghost trail.
		dir = -directions[kris.direction]
	# Fine with hardcoding values here because it's one character.
	for i in 3:
		var prog = fmod(time * 1.0 + 1.0 / 3.0 * i, 1.0)
		var offset = prog * 4.0 * dir
		draw_texture(frame, frame_position + offset, Color8(255, 255, 255, 128 - prog * 128))

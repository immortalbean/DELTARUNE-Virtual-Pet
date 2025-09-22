extends CharacterBody2D

const base_speed_light_world: float = 12.0
const run_addon_1: float = 4.0

var moving = false

var direction = "down"

@onready var sprite = $sprite

func _physics_process(_delta: float) -> void:
	velocity = Vector2.ZERO
	var current_speed = base_speed_light_world
	if Input.is_action_pressed("run"):
		current_speed += run_addon_1
	moving = false
	if Input.is_action_pressed("up"):
		velocity.y -= current_speed
		moving = true
		direction = "up"
	if Input.is_action_pressed("down"):
		velocity.y += current_speed
		moving = true
		direction = "down"
	if Input.is_action_pressed("left"):
		velocity.x -= current_speed
		moving = true
		direction = "left"
	if Input.is_action_pressed("right"):
		velocity.x += current_speed
		moving = true
		direction = "right"
	position += velocity
	if moving:
		sprite.play("walk_" + direction)
	else:
		sprite.play("idle_" + direction)

extends CharacterBody2D

const base_speed_light_world: float = 420.0
const run_addon_1: float = 240.0

const max_form: int = 3

var moving = false

@export var form: int = 0

var direction = "down"

var sprite
@onready var window_manager = $window_manager
@onready var sprite_spawner = $sprite_spawner

func _ready() -> void:
	sprite_spawner.spawn()

func _physics_process(_delta: float) -> void:
	var current_speed = base_speed_light_world
	if Input.is_action_pressed("run"):
		current_speed += run_addon_1
	moving = false
	
	velocity = Vector2.ZERO

	if Input.is_action_pressed("down"):
		velocity.y = current_speed
		moving = true
		direction = "down"
	if Input.is_action_pressed("up"):
		velocity.y = -current_speed
		moving = true
		direction = "up"
	if Input.is_action_pressed("right"):
		velocity.x = current_speed
		moving = true
		direction = "right"
	if Input.is_action_pressed("left"):
		velocity.x = -current_speed
		moving = true
		direction = "left"
	move_and_slide()
	
	if window_manager.dragging:
		sprite.play("drag")
	else:
		if moving:
			sprite.play("walk_" + direction)
		else:
			sprite.play("idle_" + direction)
	
	if Input.is_action_just_pressed("next"):
		form += 1
		form = clampi(form, 0, max_form)
		sprite_spawner.spawn()
	if Input.is_action_just_pressed("previous"):
		form -= 1
		form = clampi(form, 0, max_form)
		sprite_spawner.spawn()

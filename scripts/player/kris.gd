extends CharacterBody2D

const base_speed_light_world: float = 420.0
const run_addon_1: float = 240.0

var max_form: int

var moving = false
var ai_mode = true
var directions = [
	"down",
	"up",
	"right",
	"left"
]
var move_timer = 0

@export var form: int = 0

var direction = "down"

var sprite
@onready var window_manager = $window_manager
@onready var sprite_spawner = $sprite_spawner

func _ready() -> void:
	form = randi_range(0, max_form)
	sprite_spawner.spawn()
	window_manager.set_window_name(form)

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("menu"):
		ai_mode = not ai_mode
	if ai_mode:
		handle_random_movement()
	else:
		handle_human_input()
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
		window_manager.set_window_name(form)
	if Input.is_action_just_pressed("previous"):
		form -= 1
		form = clampi(form, 0, max_form)
		sprite_spawner.spawn()
		window_manager.set_window_name(form)
func handle_human_input():
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
func handle_random_movement():
	if move_timer <= 0:
		if randi_range(0, 5) < 1:
			moving = true
			direction = directions.pick_random()
		else:
			moving = false
		move_timer = randi_range(20, 70)
	
	var current_speed = base_speed_light_world
	
	velocity = Vector2.ZERO
	if moving:
		if direction == "down":
			velocity.y = current_speed
		if direction == "up":
			velocity.y = -current_speed
		if direction == "right":
			velocity.x = current_speed
		if direction == "left":
			velocity.x = -current_speed
	move_timer -= 1

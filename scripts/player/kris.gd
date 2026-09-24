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
# TODO: Refactor this to a seconds-based timer, would work the same but doesn't rely on 30 FPS.
var move_timer = 0

var emote = ""

@export var form: int = 0

var direction = "down"

var sprite: AnimatedSprite2D

var launch_velocity: Vector2 = Vector2.ZERO
@onready var window_manager = $window_manager
@onready var sprite_spawner = $sprite_spawner
@onready var info = $info_loader
@onready var sounds = $sounds
func _ready() -> void:
	form = randi_range(0, max_form)
	sprite_spawner.spawn()
	window_manager.set_window_name(form)
	change_form(0)

func _physics_process(delta: float) -> void:
	if not window_manager.menu_open:
		if Input.is_action_just_pressed("menu"):
			ai_mode = not ai_mode
		if ai_mode:
			handle_random_movement()
		else:
			handle_human_input()
		if not window_manager.dragging:
			velocity += launch_velocity
			launch_velocity *= 0.9
			launch_velocity.y += abs(launch_velocity.x / 30.0)
		move_and_slide()
		update_visuals()
		
		if Input.is_action_just_pressed("next"):
			change_form(1)
		if Input.is_action_just_pressed("previous"):
			change_form(-1)
	window_manager.tick(delta)
func handle_human_input():
	emote = ""
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
		move_timer = randi_range(50, 80)
		emote = ""
		var rand := randi_range(0, 16)
		if rand < 4:
			moving = true
			direction = directions.pick_random()
		elif rand < 6 and len(info.emotes[form]):
			rand_emote()
		else:
			moving = false
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
func change_form(amount: int):
	form += amount
	form = clampi(form, 0, max_form)
	window_manager.scale = info.default_scales[form]
	sprite_spawner.spawn()
	update_visuals()
	sounds.stream = load(info.sounds[form])
	window_manager.set_window_name(form)
	update_window_size()
func update_window_size():
	var sprite_size = sprite.sprite_frames.get_frame_texture("idle_down", 0).get_size()
	sprite_size *= window_manager.scale
	window_manager.set_window_size(Vector2i(sprite_size))
func update_visuals() -> void:
	if sprite.scale.x != window_manager.scale:
		sprite.scale = Vector2.ONE * window_manager.scale
		update_window_size()
	if window_manager.dragging:
		sprite.play("drag")
	else:
		if emote:
			sprite.play(emote)
		else:
			if moving:
				sprite.play("walk_" + direction)
			else:
				sprite.play("idle_" + direction)
# Set the emote state and calculate the length it should play.
func rand_emote() -> void:
	moving = false
	emote = info.emotes[form].pick_random()
	if emote:
		# Very ugly math, wish Godot gave an easier way to get the length of animations.
		# Should be prettier when I get around to refactoring the move_timer.
		var emote_seconds = 0.0
		for i in range(sprite.sprite_frames.get_frame_count(emote)):
			emote_seconds += sprite.sprite_frames.get_frame_duration(emote, i) / sprite.sprite_frames.get_animation_speed(emote)
		move_timer = int(emote_seconds * 30.0)
		move_timer = max(move_timer, 40)

# Script borrow from Novastrive.
extends Node2D

var initial_position: Vector2
@export var position_x_effect: NsValueEffect
@export var position_y_effect: NsValueEffect
@export var scale_x_effect: NsValueEffect
@export var scale_y_effect: NsValueEffect
@export var rotation_effect: NsValueEffect
@export var opacity_effect: NsValueEffect
@export var trigger_activated: bool = false
var activated = false

var time: float = 0.0

func _ready() -> void:
	initial_position = position
func activate() -> void:
	activated = true
func _physics_process(delta: float) -> void:
	if activated or not trigger_activated:
		time += delta
		var old_position = position
		if position_x_effect:
			position.x = position_x_effect.sample(time) + initial_position.x
		if position_y_effect:
			position.y = position_y_effect.sample(time) + initial_position.y
		if scale_x_effect:
			scale.x = scale_x_effect.sample(time)
		if scale_y_effect:
			scale.y = scale_y_effect.sample(time)
		var old_rotation = rotation
		if rotation_effect:
			rotation_degrees = rotation_effect.sample(time)
		if opacity_effect:
			modulate.a = opacity_effect.sample(time)
		var this: Variant = self
		if this is StaticBody2D:
			var velocity = position - old_position
			this.constant_linear_velocity = velocity / delta
			this.constant_angular_velocity = angle_difference(old_rotation, rotation) / delta

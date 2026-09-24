# Script borrowed from Novastrive, hence "ns."
class_name NsValueEffect extends Resource

enum LoopModes {
	LOOP,
	BOOMERANG,
	DONT_LOOP
}
@export var loop_mode: LoopModes = LoopModes.LOOP
@export var time_offset: float = 0.0
@export var time_speed: float = 1.0
@export var value_multiplier: float = 1.0
@export var value_offset: float = 0.0
@export var effect_curve: Curve

func sample(t: float) -> float:
	var time: float = (t + time_offset) * time_speed
	if loop_mode == LoopModes.LOOP:
		time = fmod(time, 1.0)
	elif loop_mode == LoopModes.BOOMERANG:
		time = abs(fmod(time + 1.0, 2.0) - 1.0)
	elif loop_mode == LoopModes.DONT_LOOP:
		time = clampf(time, 0.0, 1.0)
	var value = (
		(
		effect_curve.sample(time)
		* value_multiplier
		) + (
			value_offset
		)
	)
	return value

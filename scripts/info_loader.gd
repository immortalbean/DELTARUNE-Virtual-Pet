extends Node

var names = []
var scenes = []
var sounds = []
var emotes = []
var sprite_flags = []

# Use _enter_tree so that this data is loaded before any other nodes try reading it.
func _enter_tree() -> void:
	var json_str = FileAccess.open("res://assets/data/characters.json", FileAccess.READ).get_as_text()
	var json_data = JSON.parse_string(json_str)
	for i in json_data:
		# Added default values to avoid redundant JSON keys.
		var name_temp = "Kris" # Even though this is here, Kris is still named in the JSON, don't remove that.
		var scene_temp = "res://scenes/sprites/kris_light_world.tscn" # Again, redundancy for Kris in the JSON is fine.
		var sound_temp = "default"
		var emote_temp = []
		var flags_temp = "" # Should be good as just a string for now, but can be turned into an array later if needed.
		if "inherits" in i:
			var inherit = i["inherits"]
			# Switch to pre-existing lists from json data to allow layered inheritance.
			name_temp = names[inherit]
			scene_temp = scenes[inherit]
			sound_temp = sounds[inherit]
			emote_temp = emotes[inherit]
			flags_temp = sprite_flags[inherit]
		if "name" in i:
			name_temp = i["name"]
		if "sprite" in i:
			scene_temp = i["sprite"]
		if "sound" in i:
			sound_temp = i["sound"]
		if "emotes" in i:
			emote_temp = i["emotes"]
		if "sprite_flag" in i:
			flags_temp = i["sprite_flag"]
		names.append(name_temp)
		scenes.append(scene_temp)
		sounds.append(sound_temp)
		emotes.append(emote_temp)
		sprite_flags.append(flags_temp)
	# Concatenate sound file path after all inheritance is set up.
	for i in len(sounds):
		sounds[i] = "res://assets/sounds/" + sounds[i] + ".wav"
	# Concatenate flag file path after all inheritance is set up.
	for i in len(sprite_flags):
		if sprite_flags[i]:
			sprite_flags[i] = "res://scenes/sprite_flags/" + sprite_flags[i] + ".tscn"

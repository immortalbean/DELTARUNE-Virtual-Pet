extends Node

var names = []
var scenes = []
var sounds = []
var emotes = []

func _enter_tree() -> void:
	var json_str = FileAccess.open("res://assets/data/characters.json", FileAccess.READ).get_as_text()
	var json_data = JSON.parse_string(json_str)
	for i in json_data:
		var name_temp = "Kris"
		var scene_temp = "res://scenes/sprites/kris_light_world.tscn"
		var sound_temp = "default"
		var emote_temp = []
		if "inherits" in i:
			var inherit = i["inherits"]
			name_temp = names[inherit]
			scene_temp = scenes[inherit]
			sound_temp = sounds[inherit]
			emote_temp = emotes[inherit]
		if "name" in i:
			name_temp = i["name"]
		if "sprite" in i:
			scene_temp = i["sprite"]
		if "sound" in i:
			sound_temp = i["sound"]
		if "emotes" in i:
			emote_temp = i["emotes"]
		names.append(name_temp)
		scenes.append(scene_temp)
		sounds.append("res://assets/sounds/" + sound_temp + ".wav")
		emotes.append(emote_temp)

# DELTARUNE Desktop Pet
## Features:
- 30 characters built in!
- Drag characters around.
- Right click characters to open the menu.
- Throw characters around (Don't be too mean).
- Let characters emote!
- More to come!
## Contributing:
### Requirements:
- Aseprite / Libreprite
    - Used to efficiently set up and organize character sprites.
    - Optional (though heavily recommended) if you just want to fork this, but required to contribute.
	- If you do use one of these, save your file as a `.aseprite` file.
    - Use animation tags to label "idle_{direction}," "walk_{direction}," and "drag." You can also add your own as emotes.
- Godot 4.7.x
    - The engine it runs on, obviously.
- Knowledge in GDScript
    - If you only plan on contributing characters, this is completely optional!
    - Because this project was built entirely using GDScript, any code changes require knowledge of it.
- Knowledge with JSON
    - Required if you want to make characters, as they are data driven.
    - The format of `characters.json` should be fairly straight forward.
### Steps:
- Make a fork of the project.
- Open the `project.godot` file using Godot 4.7.x.
- Make commits for every change. If possible, avoid bundling changes together.
- Make a pull request with a bullet point changelog, and any unfinished features from the PR.
### Credit?:
- All contributions in the changelogs will be credited to their author.
- Additionally, there will be a list of contributors at the top of every devlog.
- You are entirely free to fork this for your own Desktop Pet, just credit me!
### Important File Paths:
- `res://assets/data/characters.json`
    - Where all the JSON character data is stored.
    - This includes:
        - "sprite" (String) - Stores the .tscn path of an `AnimatedSprite2D`.
        - "name" (String) - The name of the window for that character. Defaults to "Kris".
        - "sound" (String) - The .wav sound effect of the pet when grabbed relative to the SFX folder (see below).
        - "emotes" (Array[String]) - An array of `StringName`s that refer to character animations.
		- "sprite_flag" (String) - The .tscn scene of a visual property you can add to a character. Currently, there's only `"knight_flag"`.
		- "inherits" - (int) special property, copies the data from an earlier character IDX. You can see an example on line 9 of the file.
- `res://assets/sprites/playable/`
	- Where all the .aseprite files for the characters are stored.
	- You can see the necessary animations above. You can add custom animations for emotes.
		- For an example of this, see `res://assets/sprites/playable/pink.aseprite`.
- `res://scenes/sprites/`
	- Where all the .tscn files for the characters are stored.
	- Each should contain one `AnimatedSprite2D` node that has animations loaded through *Aseprite Wizard*.
- `res://assets/sounds/`
	- Where all the .wav files for the drag sounds are stored.
	- See examples of this used in `characters.json`.
- `res://scenes/sprite_flags/`
	- Where you can find all of the .tscn files relating to sprite flags. But only `knight_flag.tscn` is there currently.

extends Node

var score : int = 0 setget setScore
var mute : bool = false setget setMute

func _ready():
	load_game()

func setScore(val):
	score = val
	save()

func setMute(val):
	mute = val
	AudioServer.set_bus_mute(0, mute)
	save()

func getSaveDict():
	return  {
		"score" : score,
		"mute" : mute
	}

func save():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	save_game.store_line(to_json(getSaveDict()))
	save_game.close()

func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.
	
	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	save_game.open("user://savegame.save", File.READ)
	while save_game.get_position() < save_game.get_len():
		# Get the saved dictionary from the next line in the save file
		var data = parse_json(save_game.get_line())
		
		# Now we set the remaining variables.
		for i in data.keys():
			set(i, data[i])
			print(i + " is " + String(data[i]))
	
	save_game.close()

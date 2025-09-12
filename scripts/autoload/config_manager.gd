extends Node

const CFG_PATH = "user://game.cfg"
var cfg: ConfigFile

# default settings
var player_name: String = "player"
var mouse_sens: float = 0.002

func _ready() -> void:
	load_config()

func load_config():
	cfg = ConfigFile.new()
	
	if FileAccess.file_exists(CFG_PATH):
		var e = cfg.load(CFG_PATH)
		if e != OK:
			create_config()
			return
		else:
			load_settings()
	else:
		create_config()

func create_config():
	cfg = ConfigFile.new()
	
	cfg.set_value("player", "name", player_name)
	cfg.set_value("controls", "mouse_sensitivity", mouse_sens)
	# and other settings
	
	var e = cfg.save(CFG_PATH)
	load_settings()

func save_config():
	cfg.set_value("player", "name", player_name)
	cfg.set_value("controls", "mouse_sensitivity", mouse_sens)
	
	var e = cfg.save(CFG_PATH)

func load_settings():
	player_name = cfg.get_value("player", "name", player_name)
	mouse_sens = cfg.get_value("controls", "mouse_sensitivity", mouse_sens)

# special functions

func set_player_name(new_name: String):
	player_name = new_name
	save_config()

func set_mouse_sensitivity(sens: float):
	mouse_sens = sens
	save_config()

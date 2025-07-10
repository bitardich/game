extends Control

@onready var play_button = $Buttons/PlayButton
@onready var settings_button = $Buttons/SettingsButton
@onready var quit_button = $Buttons/QuitButton

const play_scene = preload("res://scenes/level/demo_world.scn")

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(play_scene)
	
func _on_settings_button_pressed() -> void:
	pass
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()

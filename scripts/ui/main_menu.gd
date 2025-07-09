extends Control

@onready var play_button = $Buttons/PlayButton
@onready var settings_button = $Buttons/SettingsButton
@onready var quit_button = $Buttons/QuitButton

func _on_quit_button_pressed() -> void:
	get_tree().quit()

extends Control

signal game_started

func _on_play_button_pressed() -> void:
	game_started.emit()

func _on_settings_button_pressed() -> void:
	pass # Replace with function body.

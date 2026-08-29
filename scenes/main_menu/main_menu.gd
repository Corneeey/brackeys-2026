extends Control

signal game_started

@onready var hover_player: AudioStreamPlayer = $HoverPlayer
@onready var click_player: AudioStreamPlayer = $ClickPlayer


func _on_play_button_pressed() -> void:
	click_player.play()
	game_started.emit()
	click_player.finished.connect(queue_free)

func _on_settings_button_pressed() -> void:
	%SettingsPopup.visible = true
	click_player.play()

func _on_play_button_mouse_entered() -> void:
	hover_player.play()

func _on_settings_button_mouse_entered() -> void:
	hover_player.play()

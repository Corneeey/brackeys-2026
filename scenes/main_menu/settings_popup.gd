extends PanelContainer

const HOVER_STREAM = preload("res://assets/sfx/menu_click/menu_click_1.wav")
const CLICK_STREAM = preload("res://assets/sfx/menu_click/menu_click_3.wav")

func set_bus_volume(bus: int, value: float) -> void:
	AudioServer.set_bus_volume_linear(bus, value)

func toggle_bus_mute(bus: int) -> bool:
	var current = AudioServer.is_bus_mute(bus)
	AudioServer.set_bus_mute(bus, !current)
	
	return !current

func _on_master_volume_slider_value_changed(value: float) -> void:
	set_bus_volume(0, value)

func _on_master_volume_mute_button_pressed() -> void:
	var muted = toggle_bus_mute(0)
	
	if muted:
		%MasterVolumeMuteButton.modulate = Color.RED
	else:
		%MasterVolumeMuteButton.modulate = Color.WHITE


func _on_music_volume_slider_value_changed(value: float) -> void:
	set_bus_volume(1, value)

func _on_music_volume_mute_button_pressed() -> void:
	var muted = toggle_bus_mute(1)
	
	if muted:
		%MusicVolumeMuteButton.modulate = Color.RED
	else:
		%MusicVolumeMuteButton.modulate = Color.WHITE

func _on_sound_volume_slider_value_changed(value: float) -> void:
	set_bus_volume(2, value)

func _on_sound_volume_mute_button_pressed() -> void:
	var muted = toggle_bus_mute(2)
	
	if muted:
		%SoundVolumeMuteButton.modulate = Color.RED
	else:
		%SoundVolumeMuteButton.modulate = Color.WHITE

func _on_back_button_pressed() -> void:
	self.visible = false
	
	$AudioStreamPlayer.stream = CLICK_STREAM
	$AudioStreamPlayer.play()

func _on_back_button_mouse_entered() -> void:
	$AudioStreamPlayer.stream = HOVER_STREAM
	$AudioStreamPlayer.play()

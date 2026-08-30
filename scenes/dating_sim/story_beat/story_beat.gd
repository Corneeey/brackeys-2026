class_name StoryBeat extends TextureRect

signal story_beat_finished(story_beat)
signal change_music(music)

var disabled = false
var visuals: Texture
var music: AudioStream

func _ready() -> void:
	if (visuals):
		texture = visuals
	
	if (music):
		change_music.emit(music)


func _on_gui_input(_event: InputEvent) -> void:
	if disabled:
		return
	
	if (Input.is_action_just_pressed("ui_click")):
		disabled = true
		story_beat_finished.emit(self)

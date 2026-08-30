class_name StoryBeat extends TextureRect

signal story_beat_finished(story_beat)

var visuals: Texture
var is_ending = false

func _ready() -> void:
	if (visuals):
		texture = visuals


func _on_gui_input(_event: InputEvent) -> void:
	if (Input.is_action_just_pressed("ui_click")):
		story_beat_finished.emit(self)

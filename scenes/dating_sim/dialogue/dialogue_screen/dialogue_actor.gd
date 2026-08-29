class_name DialogueActor extends Control

@export var talking_texture: TextureRect
@export var listening_texture: TextureRect

func set_talking() -> void:
	talking_texture.visible = true
	listening_texture.visible = false

func set_listening() -> void:
	talking_texture.visible = false
	listening_texture.visible = true

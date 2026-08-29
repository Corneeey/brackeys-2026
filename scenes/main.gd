extends Node

const DIALOGUE_SCENE = preload("uid://beviupxr7gc7m")
const MINIGAME_SCENE = preload("uid://bo8bqu8f3i8lc")

var game_steps = [
	preload("res://assets/dialogue/dialogue_1.dialogue"),
	"Minigame",
	preload("res://assets/dialogue/test.dialogue")
]

func load_next() -> void:
	var next = game_steps.pop_front()
	
	if next is DialogueResource:
		load_dialogue(next)
	elif next == "Minigame":
		load_minigame()
	else: push_error("Can't load next: " + next)

func load_dialogue(dialogue_resource: DialogueResource) -> void:
	var dialogue_scene: DialogueScene = DIALOGUE_SCENE.instantiate()
	dialogue_scene.dialogue_finished.connect(_on_dialogue_finished)
	dialogue_scene.dialogue_resource = dialogue_resource
	add_child(dialogue_scene)

func load_minigame() -> void:
	var minigame_scene = MINIGAME_SCENE.instantiate()
	add_child(minigame_scene)

func _on_main_menu_game_started() -> void:
	load_next()

func _on_dialogue_finished(dialogue_scene) -> void:
	load_next()
	dialogue_scene.queue_free()

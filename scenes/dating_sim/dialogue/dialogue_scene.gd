class_name DialogueScene extends Control

signal dialogue_finished(dialogue_scene)

enum Actor {ODYSSEUS, POLYPHEMUS}

const ACTORS: Dictionary[String, Actor] = {
	"Nobody": Actor.ODYSSEUS,
	"Odysseus": Actor.ODYSSEUS,
	"Polyphemus": Actor.POLYPHEMUS
}

const DIALOGUE_SCREEN: PackedScene = preload("res://scenes/dating_sim/dialogue/dialogue_screen/dialogue_screen.tscn")

const STORM_AUDIO: AudioStream = preload("uid://byqklnwc2ldgn")

@export var dialogue_resource: DialogueResource

var dialogue: DialogueScreen
var current_actor: Actor

func _ready() -> void:
	DialogueManager.set_default_balloon(DIALOGUE_SCREEN)
	dialogue = DialogueManager.show_dialogue_balloon(dialogue_resource)
	
	if(dialogue_resource.resource_path.contains("dialogue_2")):
		$AnimationPlayer/SFXPlayer.stream = STORM_AUDIO
		$AnimationPlayer/SFXPlayer.play()
		$AnimationPlayer.play("fade_in")


func _process(_delta: float) -> void:
	if (dialogue):
		process_dialogue()
	else:
		dialogue_finished.emit(self)


func process_dialogue() -> void:
	var actor: Actor = ACTORS[dialogue.dialogue_line.character]
	
	if (actor != current_actor):
		change_actor(actor)
	
	if (is_someone_talking()):
		play_dialogue_sound()

func is_someone_talking() -> bool:
	return !dialogue.is_waiting_for_input && !dialogue.responses_menu.visible

func play_dialogue_sound() -> void:
	match current_actor:
		Actor.ODYSSEUS:
			$OdysseusPlayer.play_audio()
		Actor.POLYPHEMUS:
			$PolyphemusPlayer.play_audio()

func change_actor(actor: Actor) -> void:
	current_actor = actor
	
	match actor:
		Actor.ODYSSEUS:
			dialogue.odysseus.set_talking()
			dialogue.polyphemus.set_listening()
			dialogue.speaker_box_left.visible = true
			dialogue.speaker_box_right.visible = false
			dialogue.character_label.reparent(dialogue.speaker_box_left)
		Actor.POLYPHEMUS:
			dialogue.polyphemus.set_talking()
			dialogue.odysseus.set_listening()
			dialogue.speaker_box_left.visible = false
			dialogue.speaker_box_right.visible = true
			dialogue.character_label.reparent(dialogue.speaker_box_right)

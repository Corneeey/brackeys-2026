extends Control

enum Actor {ODYSSEUS, POLYPHEMUS}

const ACTORS: Dictionary[String, Actor] = {
	"Nobody": Actor.ODYSSEUS,
	"Polyphemus": Actor.POLYPHEMUS
}

const DIALOGUE_SCENE: PackedScene = preload("res://scenes/dating_sim/dialogue/dialogue_screen/dialogue_screen.tscn")

@export var dialogue_resource: DialogueResource

var dialogue: DialogueScreen
var current_actor: Actor

func _ready() -> void:
	DialogueManager.set_default_balloon(DIALOGUE_SCENE)
	dialogue = DialogueManager.show_dialogue_balloon(dialogue_resource)

func _process(_delta: float) -> void:
	if (dialogue):
		process_dialogue()


func process_dialogue() -> void:
	var actor: Actor = ACTORS[dialogue.dialogue_line.character]
	
	if (actor == current_actor):
		return
	
	change_actor(actor)

func change_actor(actor: Actor) -> void:
	current_actor = actor
	
	match actor:
		Actor.ODYSSEUS:
			dialogue.odysseus.set_talking()
			dialogue.polyphemus.set_listening()
		Actor.POLYPHEMUS:
			dialogue.polyphemus.set_talking()
			dialogue.odysseus.set_listening()

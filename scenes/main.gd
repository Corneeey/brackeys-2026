extends Node

const MENU_SONG: AudioStream = preload("uid://cqx1ynfb8130s")
const SHEEP_SONG: AudioStream = preload("uid://dr3y67lvns387")
const DATING_SONG: AudioStream = preload("uid://ddhbnssdlihyx")

const DIALOGUE_SCENE = preload("uid://beviupxr7gc7m")
const MINIGAME_SCENE = preload("uid://bo8bqu8f3i8lc")
const STORY_BEAT_SCENE = preload("uid://cil3hka4svl4x")

var game_steps = [
	preload("res://assets/visualnovel/storyBeats/opening.png"),
	preload("res://assets/dialogue/dialogue_1.dialogue"),
	preload("res://assets/wiesen/wiese_1.tres"),
	preload("res://assets/dialogue/dialogue_2.dialogue"),
	preload("res://assets/wiesen/wiese_2.tres"),
	preload("res://assets/dialogue/dialogue_3.dialogue"),
	preload("res://assets/wiesen/wiese_3.tres"),
	preload("res://assets/dialogue/dialogue_4.dialogue"),
	"Ending",
]

func load_next() -> void:
	var next = game_steps.pop_front()
	
	if next is DialogueResource:
		load_dialogue(next)
	elif next is WiesenData:
		load_minigame(next)
	elif next is Texture:
		load_story_beat(next)
	elif next == "Ending":
		load_ending()
	else: push_error("Can't load next: " + next)

func load_dialogue(dialogue_resource: DialogueResource) -> void:
	var dialogue_scene: DialogueScene = DIALOGUE_SCENE.instantiate()
	dialogue_scene.dialogue_finished.connect(_on_dialogue_finished)
	dialogue_scene.dialogue_resource = dialogue_resource
	
	$MusicPlayer.stream = DATING_SONG
	$MusicPlayer.play()
	$BellRinger.play()
	
	add_child(dialogue_scene)

func load_minigame(wiesen_data: WiesenData) -> void:
	var wiese: Wiese = MINIGAME_SCENE.instantiate()
	
	wiese.minigame_has_dreck = wiesen_data.minigame_has_dreck
	wiese.minigame_has_füttern = wiesen_data.minigame_has_füttern
	wiese.minigame_has_stoecker = wiesen_data.minigame_has_stoecker
	wiese.minigame_has_streicheln = wiesen_data.minigame_has_streicheln
	wiese.sheep_count = wiesen_data.sheep_count
	wiese.clean_sheep_count = wiesen_data.clean_sheep_count
	
	wiese.wiese_exited.connect(_on_wiese_finished)
	
	$MusicPlayer.stream = SHEEP_SONG
	$MusicPlayer.play()
	$BellRinger.play()
	
	add_child(wiese)

func load_story_beat(visuals) -> void:
	var story_beat = STORY_BEAT_SCENE.instantiate()
	
	story_beat.story_beat_finished.connect(_on_story_beat_finished)
	story_beat.visuals = visuals
	
	add_child(story_beat)

func load_ending():
	var visuals
	
	if (ScoreManager.score <= ScoreManager.BAD_ENDING_THRESHOLD):
		visuals = load("res://assets/visualnovel/storyBeats/bad_ending.png")
	elif (ScoreManager.score >= ScoreManager.GOOD_ENDING_THRESHOLD):
		visuals = load("res://assets/visualnovel/storyBeats/good_ending.png")
	
	var story_beat = STORY_BEAT_SCENE.instantiate()
	
	story_beat.story_beat_finished.connect(_on_story_beat_finished)
	story_beat.visuals = visuals
	
	add_child(story_beat)

func _on_main_menu_game_started() -> void:
	load_next()

func _on_wiese_finished(wiese) -> void:
	load_next()
	wiese.queue_free()

func _on_dialogue_finished(dialogue_scene) -> void:
	load_next()
	dialogue_scene.queue_free()

func _on_story_beat_finished(story_beat) -> void:
	load_next()
	story_beat.queue_free()

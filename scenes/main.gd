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
	preload("res://assets/visualnovel/storyBeats/credits.png")
]

func load_next() -> void:
	print("Loading scene " + str(11 - game_steps.size()) + "...")
	var next = game_steps.pop_front()
	print("- Got scene: " + next.resource_path)
	
	if next is DialogueResource:
		load_dialogue(next)
	elif next is WiesenData:
		load_minigame(next)
	elif next is Texture:
		load_story_beat(next)
	elif next == "Ending":
		load_ending()
	else:
		get_tree().quit()
	
	print("Finished loading scene... Now I have " + str(get_child_count() - 2) + " children")

func load_dialogue(dialogue_resource: DialogueResource) -> void:
	print("- Loading dialogue...")
	var dialogue_scene: DialogueScene = DIALOGUE_SCENE.instantiate()
	dialogue_scene.dialogue_finished.connect(_on_dialogue_finished)
	dialogue_scene.dialogue_resource = dialogue_resource
	
	$MusicPlayer.stream = DATING_SONG
	$MusicPlayer.play()
	$BellRinger.play()
	
	add_child(dialogue_scene)

func load_minigame(wiesen_data: WiesenData) -> void:
	print("- Loading minigame...")
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
	print("- Loading story beat...")
	var story_beat = STORY_BEAT_SCENE.instantiate()
	
	story_beat.story_beat_finished.connect(_on_story_beat_finished)
	story_beat.visuals = visuals
	
	add_child(story_beat)

func load_ending():
	print("- Loading ending...")
	var visuals: Texture
	var music: AudioStream
	
	print(ScoreManager.get_score_percentage())
	
	if (ScoreManager.get_score_percentage() <= ScoreManager.BAD_ENDING_THRESHOLD):
		visuals = load("res://assets/visualnovel/storyBeats/bad_ending.png")
		music = load("res://assets/music/bad_ending.mp3")
	elif (ScoreManager.get_score_percentage() >= ScoreManager.GOOD_ENDING_THRESHOLD):
		visuals = load("res://assets/visualnovel/storyBeats/good_ending.png")
		music = load("res://assets/music/good_ending.mp3")
	
	var story_beat = STORY_BEAT_SCENE.instantiate()
	
	story_beat.story_beat_finished.connect(_on_story_beat_finished)
	story_beat.change_music.connect(_on_story_beat_music_change_signal)
	
	story_beat.visuals = visuals
	story_beat.music = music
	
	add_child(story_beat)

func _on_story_beat_music_change_signal(music: AudioStream) -> void:
	$MusicPlayer.stream = music
	$MusicPlayer.play()
	$BellRinger.play()

func _on_main_menu_game_started() -> void:
	load_next()

func _on_wiese_finished(wiese) -> void:
	print("-- Wiese finished...")
	load_next()
	wiese.queue_free()

func _on_dialogue_finished(dialogue_scene) -> void:
	print("-- Dialogue finished...")
	load_next()
	dialogue_scene.queue_free()

func _on_story_beat_finished(story_beat) -> void:
	print("-- Story beat finished...")
	load_next()
	story_beat.queue_free()

extends Node2D

var currently_hovered_tool : ToolManager.Tool = ToolManager.Tool.NONE
var is_hovering_anything = false

@onready var cursor_img : Sprite2D = $Cursor
@onready var sheep = $Sheep

@onready var mouse_texture_brush : Texture2D = load("res://assets/minigame/tools/brush.png")
@onready var mouse_texture_hand : Texture2D = load("res://assets/minigame/tools/hand.png")
@onready var mouse_texture_zange : Texture2D = load("res://assets/minigame/tools/comb.png")
@onready var mouse_texture_karrote : Texture2D = load("res://assets/minigame/tools/carrot_01.png")

@onready var minigame_audio: MinigameAudio = $MinigameAudio

@onready var hand_tool = $HandButton
@onready var brush_tool = $BrushButton
@onready var zange_tool = $CombButton
@onready var food_tool = $FoodButton

func _ready() -> void:
	ToolManager.ate_food.connect(_on_ate_food)
	_connect_sheep_signals()
	if(MinigameLevelManager.minigame_has_dreck):
		brush_tool.visible = true
	if(MinigameLevelManager.minigame_has_füttern):
		food_tool.visible = true
	if(MinigameLevelManager.minigame_has_stoecker):
		zange_tool.visible = true
	if(MinigameLevelManager.minigame_has_streicheln):
		hand_tool.visible = true

func _connect_sheep_signals() -> void:
	sheep.brushed.connect(_on_sheep_brushed)
	sheep.petted.connect(_on_sheep_petted)

func _on_sheep_brushed() -> void:
	minigame_audio.play_audio(MinigameAudio.AudioEvent.BRUSHED)

func _on_sheep_petted() -> void:
	minigame_audio.play_audio(MinigameAudio.AudioEvent.PETTED)

func _on_hand_button_toggled(toggled_on: bool) -> void:
	if(toggled_on):
		cursor_img.texture = mouse_texture_hand
		brush_tool.button_pressed = false
		zange_tool.button_pressed = false
		food_tool.button_pressed = false
		ToolManager.active_tool = ToolManager.Tool.HAND
		do_cursor_stuff(true)
	else:
		ToolManager.active_tool = ToolManager.Tool.NONE
		do_cursor_stuff(false)

func _on_brush_button_toggled(toggled_on: bool) -> void:
	if(toggled_on):
		cursor_img.texture = mouse_texture_brush
		hand_tool.button_pressed = false
		zange_tool.button_pressed = false
		food_tool.button_pressed = false
		ToolManager.active_tool = ToolManager.Tool.BRUSH
		do_cursor_stuff(true)
	else:
		ToolManager.active_tool = ToolManager.Tool.NONE
		do_cursor_stuff(false)

func _on_food_button_toggled(toggled_on: bool) -> void:
	if(toggled_on):
		cursor_img.texture = mouse_texture_karrote
		hand_tool.button_pressed = false
		brush_tool.button_pressed = false
		zange_tool.button_pressed = false
		ToolManager.active_tool = ToolManager.Tool.KAROTTE
		do_cursor_stuff(true)
	else:
		ToolManager.active_tool = ToolManager.Tool.NONE
		do_cursor_stuff(false)
		
func _on_comb_button_toggled(toggled_on: bool) -> void:
	if(toggled_on):
		cursor_img.texture = mouse_texture_zange
		hand_tool.button_pressed = false
		brush_tool.button_pressed = false
		food_tool.button_pressed = false
		ToolManager.active_tool = ToolManager.Tool.ZANGE
		do_cursor_stuff(true)
		cursor_img.scale = Vector2(0.5, 0.5)
	else:
		ToolManager.active_tool = ToolManager.Tool.NONE
		do_cursor_stuff(false)
		cursor_img.scale = Vector2(0.8, 0.8)
		
func _on_ate_food():
	minigame_audio.play_audio(MinigameAudio.AudioEvent.CARROT_FED)
	cursor_img.visible = false
	food_tool.button_pressed = false
	ScoreManager.current_food_score += ScoreManager.feed_food_score
	ToolManager.active_tool = ToolManager.Tool.NONE
	do_cursor_stuff(false)

func _on_quit_minigame_pressed() -> void:
	ScoreManager.finish_sheep()
	SheepManager.is_sheep_minigame_open = false
	do_cursor_stuff(false)
	self.queue_free()

func _process(_delta: float) -> void:
	cursor_img.global_position = get_global_mouse_position()
	
func do_cursor_stuff(visible):
	if(visible):
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
		cursor_img.visible = true
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		cursor_img.visible = false

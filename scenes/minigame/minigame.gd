extends Node2D

var currently_hovered_tool : ToolManager.Tool = ToolManager.Tool.NONE
var is_hovering_anything = false

@onready var cursor_img = $Cursor
@onready var sheep = $Sheep

@onready var texture_brush : Texture2D = load("res://assets/brush.webp")
@onready var texture_hand : Texture2D = load("res://assets/hand.png")
@onready var texture_zange : Texture2D = load("res://assets/zange.png")
@onready var texture_karrote : Texture2D = load("res://assets/340.webp")

@onready var minigame_audio: MinigameAudio = $MinigameAudio

@onready var hand_tool = $Hand
@onready var brush_tool = $Brush
@onready var zange_tool = $Zange
@onready var food_tool = $Food

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

# FOOD
func _on_food_mouse_entered() -> void:
	currently_hovered_tool = ToolManager.Tool.KAROTTE
	is_hovering_anything = true

func _on_food_mouse_exited() -> void:
	is_hovering_anything = false

#ZANGE
func _on_zange_mouse_entered() -> void:
	currently_hovered_tool = ToolManager.Tool.ZANGE # Replace with function body.
	is_hovering_anything = true

func _on_zange_mouse_exited() -> void:
	is_hovering_anything = false

#BRUSH
func _on_brush_mouse_entered() -> void:
	currently_hovered_tool = ToolManager.Tool.BRUSH
	is_hovering_anything = true

func _on_brush_mouse_exited() -> void:
	is_hovering_anything = false

#HAND
func _on_hand_mouse_entered() -> void:
	currently_hovered_tool = ToolManager.Tool.HAND
	is_hovering_anything = true

func _on_hand_mouse_exited() -> void:
	is_hovering_anything = false
	
func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("drag")):
		ToolManager.active_tool = currently_hovered_tool
		if(currently_hovered_tool == ToolManager.Tool.HAND):
			cursor_img.texture = texture_hand
			cursor_img.visible = true
		elif(currently_hovered_tool == ToolManager.Tool.ZANGE):
			cursor_img.texture = texture_zange
			cursor_img.visible = true
		elif(currently_hovered_tool == ToolManager.Tool.KAROTTE):
			cursor_img.texture = texture_karrote
			cursor_img.visible = true
		elif(currently_hovered_tool == ToolManager.Tool.BRUSH):
			cursor_img.texture = texture_brush
			cursor_img.visible = true
		else:
			cursor_img.visible = false
		
	cursor_img.global_position = get_global_mouse_position()
	
func _on_ate_food():
	minigame_audio.play_audio(MinigameAudio.AudioEvent.CARROT_FED)
	cursor_img.visible = false

func _on_quit_minigame_pressed() -> void:
	ScoreManager.finish_sheep()
	SheepManager.is_sheep_minigame_open = false
	self.queue_free()

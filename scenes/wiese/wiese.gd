class_name Wiese extends Node2D

signal wiese_exited

const MINISHEEP_SCENE = preload("res://scenes/wiese/mini_sheep.tscn")
const MINIGAME_SCENE = preload("res://scenes/minigame/minigame.tscn")

@export var minigame_has_streicheln = true
@export var minigame_has_füttern = true
@export var minigame_has_stoecker = true
@export var minigame_has_dreck = true
@export var sheep_count = 4
@export var clean_sheep_count = 2

var sheep = []

@onready var big_evil_body = $BigEvilBody

func _ready() -> void:
	MinigameLevelManager.minigame_has_dreck = minigame_has_dreck
	MinigameLevelManager.minigame_has_füttern = minigame_has_füttern
	MinigameLevelManager.minigame_has_stoecker = minigame_has_stoecker
	MinigameLevelManager.minigame_has_streicheln = minigame_has_streicheln
	for i in sheep_count:
		sheep.append(spawn_mini_sheep())
	
	for i in clean_sheep_count:
		var mini_sheep := spawn_mini_sheep()
		sheep.append(mini_sheep)
		mini_sheep.clean_sheep()
	
	await get_tree().create_timer(0.25).timeout

func _process(_delta: float) -> void:
	#if (!sheep.any(_is_evil) && big_evil_body):
		#big_evil_body.queue_free()
	pass

func _is_evil(singular_sheep) -> bool:
	return singular_sheep.is_evil

func _get_rect() -> Rect2:
	var rect: Rect2 = $SheepArea/CollisionShape2D.shape.get_rect()
	rect.position += $SheepArea/CollisionShape2D.global_position
	return rect
	

func spawn_mini_sheep() -> Node:
	var mini_sheep: Node = MINISHEEP_SCENE.instantiate()
	mini_sheep.open_sheep.connect(_open_sheep)
	mini_sheep.roaming_area = _get_rect()
	$SheepArea.add_child(mini_sheep)
	return mini_sheep

func _open_sheep() -> void:
	add_child(MINIGAME_SCENE.instantiate())
	SheepManager.is_sheep_minigame_open = true

func _on_back_button_pressed() -> void:
	wiese_exited.emit(self)

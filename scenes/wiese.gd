extends Node2D

const MINISHEEP_SCENE = preload("res://scenes/mini_sheep.tscn")
const MINIGAME_SCENE = preload("res://scenes/minigame/minigame.tscn")

@export var minigame_has_streicheln = true
@export var minigame_has_füttern = true
@export var minigame_has_stoecker = true
@export var minigame_has_dreck = true
@export var sheep_count = 4

func _ready() -> void:
	for i in sheep_count:
		spawn_mini_sheep()

func spawn_mini_sheep() -> void:
	var mini_sheep = MINISHEEP_SCENE.instantiate()
	mini_sheep.open_sheep.connect(_open_sheep)
	add_child(mini_sheep)

func _open_sheep() -> void:
	add_child(MINIGAME_SCENE.instantiate())

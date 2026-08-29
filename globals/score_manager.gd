extends Node

@export_range(0, 50)
var dirt_clean_score = 10

@export_range(0, 50)
var feed_food_score = 5

@export_range(0, 50)
var remove_stick_score = 15

@export_range(0, 1)
var scratch_score_per_movement = 0.001

var score = 0

func _process(_delta: float) -> void:
	#pass
	print("Score: ", score)

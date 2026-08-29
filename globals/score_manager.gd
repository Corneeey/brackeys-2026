extends Node

@export_range(0, 50)
var dirt_clean_score = 10

@export_range(0, 50)
var feed_food_score = 5

@export_range(0, 1)
var scratch_score_per_movement = 0.01

var score = 0

func _process(delta: float) -> void:
	print("Score: ", score)

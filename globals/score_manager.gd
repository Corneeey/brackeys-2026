extends Node

@export_range(0, 50)
var dirt_clean_score = 10

@export_range(0, 50)
var max_dirt_clean_score_per_sheep = 10

var current_dirt_score = 0

@export_range(0, 50)
var feed_food_score = 5

@export_range(0, 50)
var max_feed_food_score_per_sheep = 5

var current_food_score = 0

@export_range(0, 50)
var remove_stick_score = 15

@export_range(0, 50)
var max_remove_stick_score_per_sheep = 15

var current_remove_stick_score = 0

@export_range(0, 1)
var scratch_score_per_movement = 0.001

@export_range(0, 50)
var max_scratch_score_per_sheep = 10

var current_scratch_score = 0

@export_range(0, 5000)
var max_score = 2000

@export_range(0, 5000)
var max_score_per_sheep = 300

var score = 0

func get_score_percentage():
	return min(score, max_score)/max_score * 10

func finish_sheep():
	var sheep_score: int = 0
	sheep_score += min(current_dirt_score, max_dirt_clean_score_per_sheep)
	sheep_score += min(current_food_score, max_feed_food_score_per_sheep)
	sheep_score += min(current_remove_stick_score, max_remove_stick_score_per_sheep)
	sheep_score += min(current_scratch_score, max_scratch_score_per_sheep)
	score += min(max_score_per_sheep, sheep_score)

	current_dirt_score = 0
	current_food_score = 0
	current_remove_stick_score = 0
	current_scratch_score = 0

func _process(_delta: float) -> void:
	pass
	#print("Score: ", score)

extends Node

#Änderungwerte
var scratch_score_per_movement = 0.1
var remove_stick_score = 60
var feed_food_score = 40
var dirt_clean_score = 50
var answer_change = 200

#max-Werte
var max_score = 4000
var max_score_per_sheep = 500

#max-Werte pro Schaf
var max_scratch_score_per_sheep = 100
var max_feed_food_score_per_sheep = 150
var max_dirt_clean_score_per_sheep = 250
var max_remove_stick_score_per_sheep = 150

#dynamically filled values
var current_food_score = 0
var current_scratch_score = 0
var current_remove_stick_score = 0
var current_dirt_score = 0
var score = 0

func get_score_percentage():
	var score_percentage = min(score, max_score) * 100/max_score
	print(score_percentage, score)
	return score_percentage
	

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
	
func resolve_evil_answer() -> void:
	score -= answer_change
	
func resolve_good_answer() -> void:
	score += answer_change
	
func _process(_delta: float) -> void:
	pass
	#print("Score: ", score)

extends Area2D

var is_getting_cleaned = false
var dirt_alpha = 1
var is_scored = false

func _mouse_enter() -> void:
	is_getting_cleaned = true
	
func _mouse_exit() -> void:
	is_getting_cleaned = false
	
func _input(event: InputEvent) -> void:
	if(event is InputEventMouseMotion && is_getting_cleaned):
		self.modulate = Color(self.modulate, dirt_alpha)
		dirt_alpha -= 0.008
		
	if(dirt_alpha < 0.1):
		self.visible = false
		if(!is_scored):
			ScoreManager.score += ScoreManager.dirt_clean_score
			is_scored = true

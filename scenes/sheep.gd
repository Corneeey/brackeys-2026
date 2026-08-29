extends Sprite2D

var is_in_hover_on_body = false 
@export var has_food = false

func _on_sheep_body_mouse_entered() -> void:
	is_in_hover_on_body = true

func _on_sheep_body_mouse_exited() -> void:
	is_in_hover_on_body = false
	
func _on_sheep_mouth_mouse_entered() -> void:
	if(has_food):
		ScoreManager.score += ScoreManager.feed_food_score
		has_food = false
		
func _input(event: InputEvent) -> void:
	if(event is InputEventMouseMotion && is_in_hover_on_body):
		ScoreManager.score += ScoreManager.scratch_score_per_movement
			

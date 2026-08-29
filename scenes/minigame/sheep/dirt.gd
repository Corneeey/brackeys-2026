extends Area2D

var is_hovering = false
var dirt_alpha = 1
var is_scored = false

func _mouse_enter() -> void:
	is_hovering = true
	
func _mouse_exit() -> void:
	is_hovering = false
	
func _input(event: InputEvent) -> void:
	if(event is InputEventMouseMotion 
			&& is_hovering 
			&& ToolManager.active_tool == ToolManager.Tool.BRUSH):
		self.modulate = Color(self.modulate, dirt_alpha)
		dirt_alpha -= 0.008
		
	if(dirt_alpha < 0.1):
		self.visible = false
		if(!is_scored):
			ScoreManager.score += ScoreManager.dirt_clean_score
			is_scored = true

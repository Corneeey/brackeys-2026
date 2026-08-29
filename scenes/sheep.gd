extends Sprite2D

var is_in_hover_on_body = false

func _ready() -> void:
	SheepManager.sheep_body = $SheepBody

func _on_sheep_body_mouse_entered() -> void:
	is_in_hover_on_body = true

func _on_sheep_body_mouse_exited() -> void:
	is_in_hover_on_body = false
	
func _on_sheep_mouth_mouse_entered() -> void:
	if(ToolManager.active_tool == ToolManager.Tool.KAROTTE):
		ScoreManager.score += ScoreManager.feed_food_score
		ToolManager.active_tool = ToolManager.Tool.NONE
		ToolManager.ate_food.emit()

func _input(event: InputEvent) -> void:
	if (event is InputEventMouseMotion 
			&& is_in_hover_on_body 
			&& ToolManager.active_tool == ToolManager.Tool.HAND):
		ScoreManager.score += ScoreManager.scratch_score_per_movement

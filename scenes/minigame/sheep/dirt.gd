class_name Dirt extends Area2D

signal brushed

var is_hovering = false
var dirt_alpha = 1
var is_scored = false

func _mouse_enter() -> void:
	is_hovering = true
	
func _mouse_exit() -> void:
	is_hovering = false
	
func _input(event: InputEvent) -> void:
	if(is_brushing(event)):
		apply_brush()
	
	if (dirt_alpha < 0.1):
		clear_dirt()

func is_brushing(event: InputEvent) -> bool:
	return (
		event is InputEventMouseMotion
		&& is_hovering
		&& ToolManager.active_tool == ToolManager.Tool.BRUSH
	)

func apply_brush() -> void:
	self.modulate = Color(self.modulate, dirt_alpha)
	dirt_alpha -= 0.008
	brushed.emit()

func clear_dirt() -> void:
	self.visible = false
	if(!is_scored):
		ScoreManager.score += ScoreManager.dirt_clean_score
		is_scored = true

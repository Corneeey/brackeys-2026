extends Sprite2D

signal brushed
signal petted
signal stick_removed

var is_in_hover_on_body = false 

func _ready() -> void:
	SheepManager.sheep_body = $SheepBody
	_connect_dirt_signals()
	_take_care_of_stick()

func _connect_dirt_signals() -> void:
	for child in get_children():
		if child is Dirt:
			child.brushed.connect(brushed.emit)
			if(MinigameLevelManager.minigame_has_dreck):
				child.visible = true
				
func _take_care_of_stick() -> void:
	for child in get_children():
		if child is Stick:
			child.stick_removed.connect(stick_removed.emit)
			
			if(MinigameLevelManager.minigame_has_stoecker):
				child.visible = true

func _on_sheep_body_mouse_entered() -> void:
	is_in_hover_on_body = true

func _on_sheep_body_mouse_exited() -> void:
	is_in_hover_on_body = false
	
func _on_sheep_mouth_mouse_entered() -> void:
	if(ToolManager.active_tool == ToolManager.Tool.KAROTTE):
		ScoreManager.current_food_score += ScoreManager.feed_food_score
		ToolManager.active_tool = ToolManager.Tool.NONE
		ToolManager.ate_food.emit()

func _input(event: InputEvent) -> void:
	if (_is_petting_event(event)):
		pet_sheep()

func pet_sheep() -> void:
	petted.emit()
	ScoreManager.current_scratch_score += ScoreManager.scratch_score_per_movement

func _is_petting_event(event: InputEvent) -> bool:
	return (
		event is InputEventMouseMotion
		&& is_in_hover_on_body
		&& ToolManager.active_tool == ToolManager.Tool.HAND
	)

class_name Stick extends Area2D

signal stick_removed

var is_draggable = false
var offset : Vector2

var is_dissolving = false
var alpha = 1

@export var texture : Texture2D
@onready var child_texture = $CollisionShape2D/Sprite2D

func _ready() -> void:
	child_texture.texture = texture

func _process(delta: float) -> void:
	if(is_draggable):
		if(Input.is_action_just_pressed("drag")):
			offset = get_global_mouse_position() - global_position
			DraggableManager.is_currently_dragging_something = true
		if(Input.is_action_pressed("drag")):
			global_position = get_global_mouse_position() - offset
		elif(Input.is_action_just_released("drag")):
			DraggableManager.is_currently_dragging_something = false
			if(!$MiddleCollision.overlaps_area(SheepManager.sheep_body)):
				trigger_stick_removal()

	if(is_dissolving):
		self.modulate = Color(self.modulate, alpha)
		alpha -= delta

func trigger_stick_removal() -> void:
	stick_removed.emit()
	is_dissolving = true
	ScoreManager.current_remove_stick_score += ScoreManager.remove_stick_score

func _mouse_enter() -> void:
	if(!DraggableManager.is_currently_dragging_something 
			&& !is_dissolving 
			&& ToolManager.active_tool == ToolManager.Tool.ZANGE):
		is_draggable = true
		scale = Vector2(1.1, 1.1)
	
func _mouse_exit() -> void:
	if(!DraggableManager.is_currently_dragging_something):
		is_draggable = false
		scale = Vector2(1, 1)

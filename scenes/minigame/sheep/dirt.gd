class_name Dirt extends Area2D

signal brushed

var is_hovering = false
var dirt_alpha = 1
var is_scored = false

@export var which_dirt = "head"

@onready var dirt_head = $DirtHead
@onready var dirt_up_right = $DirtUpRight
@onready var dirt_top_mid = $DirtTopMid
@onready var dirt_down_left = $DirtDownLeft
@onready var dirt_down_right = $DirtDownRight

func _ready() -> void:
	if(which_dirt == "head"):
		dirt_head.visible = true
		dirt_head.disabled = false
	elif(which_dirt == "up_right"):
		dirt_up_right.visible = true
		dirt_up_right.disabled = false
	elif(which_dirt == "top_mid"):
		dirt_top_mid.visible = true
		dirt_top_mid.disabled = false
	elif(which_dirt == "down_left"):
		dirt_down_left.visible = true
		dirt_down_left.disabled = false
	elif(which_dirt == "down_right"):
		dirt_down_right.visible = true
		dirt_down_right.disabled = false

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
		ScoreManager.current_dirt_score += ScoreManager.dirt_clean_score
		is_scored = true

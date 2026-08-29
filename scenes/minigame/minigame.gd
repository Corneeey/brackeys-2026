extends Node2D

var currently_hovered_tool : ToolManager.Tool = ToolManager.Tool.NONE
var is_hovering_anything = false

@onready var cursor_img = $Cursor

@onready var texture_brush : Texture2D = load("res://assets/brush.webp")
@onready var texture_hand : Texture2D = load("res://assets/hand.png")
@onready var texture_zange : Texture2D = load("res://assets/zange.png")
@onready var texture_karrote : Texture2D = load("res://assets/340.webp")

func _ready() -> void:
	ToolManager.ate_food.connect(_on_ate_food)

# FOOD
func _on_food_mouse_entered() -> void:
	currently_hovered_tool = ToolManager.Tool.KAROTTE
	is_hovering_anything = true

func _on_food_mouse_exited() -> void:
	is_hovering_anything = false

#ZANGE
func _on_zange_mouse_entered() -> void:
	currently_hovered_tool = ToolManager.Tool.ZANGE # Replace with function body.
	is_hovering_anything = true

func _on_zange_mouse_exited() -> void:
	is_hovering_anything = false

#BRUSH
func _on_brush_mouse_entered() -> void:
	currently_hovered_tool = ToolManager.Tool.BRUSH
	is_hovering_anything = true

func _on_brush_mouse_exited() -> void:
	is_hovering_anything = false

#HAND
func _on_hand_mouse_entered() -> void:
	currently_hovered_tool = ToolManager.Tool.HAND
	is_hovering_anything = true

func _on_hand_mouse_exited() -> void:
	is_hovering_anything = false
	
func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("drag")):
		ToolManager.active_tool = currently_hovered_tool
		if(currently_hovered_tool == ToolManager.Tool.HAND):
			cursor_img.texture = texture_hand
			cursor_img.visible = true
		elif(currently_hovered_tool == ToolManager.Tool.ZANGE):
			cursor_img.texture = texture_zange
			cursor_img.visible = true
		elif(currently_hovered_tool == ToolManager.Tool.KAROTTE):
			cursor_img.texture = texture_karrote
			cursor_img.visible = true
		elif(currently_hovered_tool == ToolManager.Tool.BRUSH):
			cursor_img.texture = texture_brush
			cursor_img.visible = true
		else:
			cursor_img.visible = false
		
	cursor_img.global_position = get_global_mouse_position()
	
func _on_ate_food():
	cursor_img.visible = false

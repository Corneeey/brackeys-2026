extends Node

var currently_hovered_tool : ToolManager.Tool = ToolManager.Tool.NONE
var is_hovering_anything = false

@onready var tool_text = $ToolText

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
	
func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("drag")):
		ToolManager.active_tool = currently_hovered_tool
		tool_text.text = ToolManager.get_name_for_tool(currently_hovered_tool)

extends Node

@onready var sheep = $Sheep

func _on_food_mouse_entered() -> void:
	sheep.has_food = true # Replace with function body.

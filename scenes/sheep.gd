extends Sprite2D

var is_in_hover_on_body = false 
var is_hover_on_dirt = false
@export var has_food = false

var time_cared_for_sheep = 0.0
var sheep_care = 0.0

func _on_dirt_mouse_entered() -> void:
	is_hover_on_dirt = true

func _on_dirt_mouse_exited() -> void:
	is_hover_on_dirt = false

func _on_sheep_body_mouse_entered() -> void:
	is_in_hover_on_body = true

func _on_sheep_body_mouse_exited() -> void:
	is_in_hover_on_body = false
	
func _on_sheep_mouth_mouse_entered() -> void:
	if(has_food):
		sheep_care += 5
		has_food = false

func _process(delta: float) -> void:
	print("Sheep-Care ", sheep_care)
	
	if(is_in_hover_on_body):
		time_cared_for_sheep += delta
		
	if(is_hover_on_dirt):
		sheep_care += 0.1
